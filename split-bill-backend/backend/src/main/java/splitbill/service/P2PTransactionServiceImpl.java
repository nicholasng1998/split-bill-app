package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import splitbill.bean.*;
import splitbill.dao.*;
import splitbill.model.ExpensesDetailsModel;
import splitbill.model.ExpensesGroupModel;
import splitbill.model.P2PTransactionModel;
import splitbill.util.AuthUtil;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;

@Slf4j
@Service
@RequiredArgsConstructor
public class P2PTransactionServiceImpl implements P2PTransactionService{

    private final UserRepository userRepository;
    private final P2PTransactionRepository p2PTransactionRepository;
    private final P2PSetupRepository p2PSetupRepository;
    private static final BigDecimal P2P_INTEREST_PERCENT = new BigDecimal("1.05");
    private static final int SETTLEMENT_PERIOD = 90;
    private static final String GROUP_NAME_FORMAT = "Settlement With P2P Merchant: %s";

    private final ExpensesGroupRepository expensesGroupRepository;

    private final UserExpensesGroupRepository userExpensesGroupRepository;

    private final ExpensesDetailsService expensesDetailsService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void createTransaction(P2PTransactionModel p2PTransactionModel) {
        String username = AuthUtil.getUsername();

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_YEAR, SETTLEMENT_PERIOD);

        P2PSetupBean p2PSetupBean = p2PSetupRepository.findByUserId(p2PTransactionModel.getMerchantId());
        BigDecimal newRemainingAmount = p2PSetupBean.getRemainingAmount().subtract(p2PTransactionModel.getLendAmount());
        p2PSetupBean.setRemainingAmount(newRemainingAmount);
        p2PSetupBean.setUpdatedDate(new Date());
        log.info("p2pSetupBean: {}", p2PSetupBean);

        P2PTransactionBean p2PTransactionBean = new P2PTransactionBean();
        BeanUtils.copyProperties(p2PTransactionModel, p2PTransactionBean);
        p2PTransactionBean.setUserId(userBean.getUserId());
        p2PTransactionBean.setMerchantId(p2PTransactionModel.getMerchantId());
        p2PTransactionBean.setStatus("active");
        p2PTransactionBean.setSettlementDate(new Date());
        p2PTransactionBean.setPaidAmount(new BigDecimal(0));
        p2PTransactionRepository.save(p2PTransactionBean);
        log.info("p2PTransactionBean: {}", p2PTransactionBean);


        UserBean merchantBean = userRepository.getOne(p2PTransactionModel.getMerchantId());
        BigDecimal totalExpenses = newRemainingAmount.multiply(P2P_INTEREST_PERCENT);
        ExpensesGroupModel expensesGroupModel = new ExpensesGroupModel();
        expensesGroupModel.setTotalExpenses(totalExpenses);
        expensesGroupModel.setGroupName(String.format(GROUP_NAME_FORMAT, merchantBean.getName()));
        expensesGroupModel.setHost(merchantBean.getUserId());
        expensesGroupModel.setDueDate(calendar.getTime());
        log.info("expensesGroupModel: {}", expensesGroupModel);
        ExpensesGroupBean expensesGroupBean = createGroupForP2P(expensesGroupModel);

        addUserToGroup(merchantBean.getUserId(), expensesGroupBean.getGroupId());
        addUserToGroup(userBean.getUserId(), expensesGroupBean.getGroupId());
        log.info("added 2 users into group!");

        ExpensesDetailsModel expensesDetailsModel = new ExpensesDetailsModel();
        expensesDetailsModel.setAmount(totalExpenses);
        expensesDetailsModel.setGroupId(expensesGroupBean.getGroupId());
        expensesDetailsModel.setItemName("P2P Repayment");
        expensesDetailsService.addItemization(expensesDetailsModel);

        log.info("done");
    }

    void addUserToGroup(int userId, int groupId) {
        UserExpensesGroupBean userExpensesGroupBean = new UserExpensesGroupBean();
        userExpensesGroupBean.setUserId(userId);
        userExpensesGroupBean.setGroupId(groupId);
        userExpensesGroupBean.setJoinDate(new Date());
        userExpensesGroupRepository.save(userExpensesGroupBean);
    }

    ExpensesGroupBean createGroupForP2P(ExpensesGroupModel expensesGroupModel) {
        ExpensesGroupBean expensesGroupBean = new ExpensesGroupBean();
        expensesGroupBean.setGroupName(expensesGroupModel.getGroupName());
        expensesGroupBean.setTotalExpenses(expensesGroupModel.getTotalExpenses() != null?
                expensesGroupModel.getTotalExpenses() : BigDecimal.ZERO);
        expensesGroupBean.setPaidAmount(BigDecimal.ZERO);
        expensesGroupBean.setOutstandingAmount(expensesGroupBean.getTotalExpenses());
        expensesGroupBean.setStatus(ExpensesGroupBean.STATUS.STARTED.toValue());
        expensesGroupBean.setHost(expensesGroupModel.getHost());
        expensesGroupBean.setDueDate(expensesGroupModel.getDueDate());
        expensesGroupBean.setCreatedDate(new Date());
        expensesGroupBean.setUpdatedDate(new Date());
        expensesGroupRepository.save(expensesGroupBean);
        log.info("expensesGroupBean: {}", expensesGroupBean);
        return expensesGroupBean;
    }
}
