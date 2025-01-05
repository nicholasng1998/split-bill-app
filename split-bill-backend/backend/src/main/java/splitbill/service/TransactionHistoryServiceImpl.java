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
import splitbill.model.TransactionHistoryModel;
import splitbill.util.AuthUtil;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class TransactionHistoryServiceImpl implements TransactionHistoryService{

    private final UserRepository userRepository;
    private final TransactionHistoryRepository transactionHistoryRepository;
    private final ExpensesGroupRepository expensesGroupRepository;
    private final ActivityService activityService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void makePayment(TransactionHistoryModel transactionHistoryModel) {
        String username = AuthUtil.getUsername();

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        TransactionHistoryBean transactionHistoryBean = new TransactionHistoryBean();
        transactionHistoryBean.setTransactionDate(new Date());
        transactionHistoryBean.setTransactionAmount(transactionHistoryModel.getTransactionAmount());
        transactionHistoryBean.setTransactionType(transactionHistoryModel.getTransactionType());
        transactionHistoryBean.setUserId(userBean.getUserId());
        transactionHistoryBean.setGroupId(transactionHistoryModel.getGroupId());
        log.info("transactionHistoryBean: {}", transactionHistoryBean);
        transactionHistoryRepository.save(transactionHistoryBean);

        ExpensesGroupBean expensesGroupBean = expensesGroupRepository.findById(transactionHistoryModel.getGroupId()).orElse(null);
        log.info("expensesGroupBean: {}", expensesGroupBean);

        if (expensesGroupBean != null) {
            expensesGroupBean.setPaidAmount(expensesGroupBean.getPaidAmount().add(transactionHistoryModel.getTransactionAmount()));
            expensesGroupBean.setOutstandingAmount(expensesGroupBean.getOutstandingAmount().min(transactionHistoryBean.getTransactionAmount()));
            expensesGroupRepository.save(expensesGroupBean);
        }

        activityService.saveActivity("Make Payment", String.format("You have paid RM%.2f to %s.", transactionHistoryModel.getTransactionAmount(), expensesGroupBean.getGroupName()));

    }

    @Override
    @Transactional(readOnly = true)
    public List<TransactionHistoryModel> readTransactionHistory(TransactionHistoryModel transactionHistoryModel) {
        int groupId = transactionHistoryModel.getGroupId();

        String username = AuthUtil.getUsername();

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        ExpensesGroupBean expensesGroupBean = expensesGroupRepository.findById(groupId).orElse(null);
        if (expensesGroupBean == null) {
            throw new InternalError("group.not.found");
        }

        List<TransactionHistoryBean> transactionHistoryBeans = new ArrayList<>();
        if (transactionHistoryModel.getTransactionDate() == null) {
            transactionHistoryBeans = transactionHistoryRepository.findAllByUserIdAndGroupId(userBean.getUserId(), groupId);
        } else {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String formattedDate = sdf.format(transactionHistoryModel.getTransactionDate());
            transactionHistoryBeans = transactionHistoryRepository.findAllByTransactionDateAndGroupId(formattedDate, groupId);
        }

        log.info("transactionHistoryBeans: {}", transactionHistoryBeans);
        if (CollectionUtils.isEmpty(transactionHistoryBeans)) {
            return null;
        }

        List<TransactionHistoryModel> transactionHistoryModels = new ArrayList<>();
        transactionHistoryBeans.forEach((bean) -> {
            TransactionHistoryModel model = new TransactionHistoryModel();
            BeanUtils.copyProperties(bean, model);
            transactionHistoryModels.add(model);
        });
        log.info("transactionHistoryModels: {}", transactionHistoryModels);
        return transactionHistoryModels;



    }
}
