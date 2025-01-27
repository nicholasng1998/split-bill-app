package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import splitbill.bean.ExpensesGroupBean;
import splitbill.bean.TransactionHistoryBean;
import splitbill.bean.UserBean;
import splitbill.dao.ExpensesGroupRepository;
import splitbill.dao.TransactionHistoryRepository;
import splitbill.dao.UserRepository;
import splitbill.model.*;
import splitbill.util.AuthUtil;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExpensesGroupServiceImpl implements ExpensesGroupService {

    private final ExpensesGroupRepository expensesGroupRepository;
    private final UserRepository userRepository;
    private final UserExpensesGroupService userExpensesGroupService;
    private final ExpensesDetailsService expensesDetailsService;
    private final TransactionHistoryRepository transactionHistoryRepository;

    private final ActivityService activityService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void createGroup(ExpensesGroupModel expensesGroupModel) {
        String username = AuthUtil.getUsername();

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        ExpensesGroupBean expensesGroupBean = this.initExpensesGroupBean(userBean.getUserId(), expensesGroupModel);
        expensesGroupRepository.save(expensesGroupBean);

        userExpensesGroupService.addUserToGroup(userBean.getUsername(), expensesGroupBean.getGroupId());
    }

    private ExpensesGroupBean initExpensesGroupBean(int userId, ExpensesGroupModel expensesGroupModel) {
        ExpensesGroupBean expensesGroupBean = new ExpensesGroupBean();
        expensesGroupBean.setGroupName(expensesGroupModel.getGroupName());
        expensesGroupBean.setTotalExpenses(expensesGroupModel.getTotalExpenses() != null?
                expensesGroupModel.getTotalExpenses() : BigDecimal.ZERO);
        expensesGroupBean.setPaidAmount(BigDecimal.ZERO);
        expensesGroupBean.setOutstandingAmount(expensesGroupBean.getTotalExpenses());
        expensesGroupBean.setStatus(ExpensesGroupBean.STATUS.WAITING.toValue());
        expensesGroupBean.setHost(userId);
        expensesGroupBean.setDueDate(expensesGroupModel.getDueDate());
        expensesGroupBean.setCreatedDate(new Date());
        expensesGroupBean.setUpdatedDate(new Date());
        return expensesGroupBean;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateGroupStatusToStarted(int groupId) {
        ExpensesGroupBean expensesGroupBean = expensesGroupRepository.findById(groupId).orElse(null);

        if (expensesGroupBean == null) {
            throw new InternalError("invalid.request");
        }

        expensesGroupBean.setStatus(ExpensesGroupBean.STATUS.STARTED.toValue());
        expensesGroupRepository.save(expensesGroupBean);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateGroupStatusToClosed(int groupId) {
        ExpensesGroupBean expensesGroupBean = expensesGroupRepository.findById(groupId).orElse(null);

        if (expensesGroupBean == null) {
            throw new InternalError("invalid.request");
        }

        expensesGroupBean.setStatus(ExpensesGroupBean.STATUS.CLOSED.toValue());
        expensesGroupRepository.save(expensesGroupBean);
    }

    @Override
    @Transactional(readOnly = true)
    public GroupDetailsModel readGroupDetails(int groupId) {
        ExpensesGroupBean expensesGroupBean = expensesGroupRepository.findById(groupId).orElse(null);
        log.info("expensesGroupBean: {}", expensesGroupBean);
        if (expensesGroupBean == null) {
            throw new InternalError("invalid.request");
        }

        List<UserModel> userModels = userExpensesGroupService.readAllUsersFromGroup(groupId);
        log.info("userModels: {}", userModels);

        if (CollectionUtils.isEmpty(userModels)) {
            return null;
        }

        String username = AuthUtil.getUsername();

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        List<ExpensesDetailsModel> expensesDetailsModels = expensesDetailsService.readAllItemization(groupId);
        log.info("expensesDetailsModels: {}", expensesDetailsModels);

        userModels.forEach(userModel -> {
            userModel.setTotalOweAmount(BigDecimal.ZERO);
        });

        if (!CollectionUtils.isEmpty(expensesDetailsModels)) {
            for (ExpensesDetailsModel expensesDetailsModel: expensesDetailsModels) {
                UserModel userModel = userModels.stream().filter(userModel1 -> userModel1.getUserId() == expensesDetailsModel.getCreatedBy()).findAny().orElse(null);
                if (userModel != null) {
                    userModel.setTotalOweAmount(userModel.getTotalOweAmount().add(expensesDetailsModel.getAmount()));
                }
            }
        }

        List<TransactionHistoryBean> transactionHistoryBeans = transactionHistoryRepository.findByGroupId(groupId);

        List<TransactionHistoryModel> transactionHistoryModels = new ArrayList<>();
        transactionHistoryBeans.forEach(transactionHistoryBean -> {
            TransactionHistoryModel transactionHistoryModel = new TransactionHistoryModel();
            BeanUtils.copyProperties(transactionHistoryBean, transactionHistoryModel);
            UserBean userBean1 = userRepository.getOne(transactionHistoryBean.getUserId());
            transactionHistoryModel.setUserIdName(userBean1.getName());
            transactionHistoryModels.add(transactionHistoryModel);
        });
        log.info("transactionHistoryModels: {}", transactionHistoryModels);

        boolean isHost = userBean.getUserId() == expensesGroupBean.getHost();
        log.info("isHost: {}", isHost);

        ExpensesGroupModel expensesGroupModel = userExpensesGroupService.readGroup(groupId);
        log.info("expensesGroupModel: {}", expensesGroupModel);

        GroupDetailsModel groupDetailsModel = new GroupDetailsModel();
        groupDetailsModel.setUserModels(userModels);
        groupDetailsModel.setExpensesDetailsModels(expensesDetailsModels);
        groupDetailsModel.setTransactionHistoryModels(transactionHistoryModels);
        groupDetailsModel.setExpensesGroupModel(expensesGroupModel);
        groupDetailsModel.setHost(isHost);

        log.info("groupDetailsModel: {}", groupDetailsModel);
        return groupDetailsModel;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void remindUser(int groupId) {
        String username = AuthUtil.getUsername();

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        List<UserModel> userModels = userExpensesGroupService.readAllUsersFromGroup(groupId);
        ExpensesGroupModel expensesGroupModel = userExpensesGroupService.readGroup(groupId);

        for (UserModel userModel : userModels) {
            if (userModel.getUserId() == userBean.getUserId()) {
                continue;
            }
            String activity = "Payment Reminder";
            String action = String.format("Payment reminder from group: %s. Settlement date is: %s", expensesGroupModel.getGroupName(), expensesGroupModel.getDueDate());
            activityService.saveActivityForUser(activity, action, userModel.getUserId());
        }

        log.info("done reminder.");
    }
}
