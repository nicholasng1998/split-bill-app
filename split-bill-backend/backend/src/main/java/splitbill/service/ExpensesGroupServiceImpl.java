package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import splitbill.bean.ExpensesGroupBean;
import splitbill.bean.UserBean;
import splitbill.dao.ExpensesGroupRepository;
import splitbill.dao.UserRepository;
import splitbill.model.ExpensesGroupModel;
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

}
