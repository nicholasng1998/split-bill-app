package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import splitbill.bean.ExpensesDetailsBean;
import splitbill.bean.ExpensesGroupBean;
import splitbill.bean.UserBean;
import splitbill.dao.ExpensesGroupRepository;
import splitbill.dao.UserRepository;
import splitbill.model.ExpensesDetailsModel;
import splitbill.model.ExpensesGroupModel;
import splitbill.model.GroupDetailsModel;
import splitbill.model.UserModel;
import splitbill.util.AuthUtil;

import java.math.BigDecimal;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExpensesGroupServiceImpl implements ExpensesGroupService {

    private final ExpensesGroupRepository expensesGroupRepository;
    private final UserRepository userRepository;
    private final UserExpensesGroupService userExpensesGroupService;
    private final ExpensesDetailsService expensesDetailsService;

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
        return expensesGroupBean;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateGroupStatusToStarted(int groupId) {
        ExpensesGroupBean expensesGroupBean = expensesGroupRepository.findById(groupId).orElse(null);

        if (expensesGroupBean == null) {
            throw new InternalError("invalid.request");
        }

        expensesGroupBean.setStatus(ExpensesGroupBean.STATUS.WAITING.toValue());
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

        boolean isHost = userBean.getUserId() == expensesGroupBean.getHost();
        log.info("isHost: {}", isHost);

        GroupDetailsModel groupDetailsModel = new GroupDetailsModel();
        groupDetailsModel.setUserModels(userModels);
        groupDetailsModel.setExpensesDetailsModels(expensesDetailsModels);
        groupDetailsModel.setHost(isHost);

        log.info("groupDetailsModel: {}", groupDetailsModel);
        return groupDetailsModel;
    }
}
