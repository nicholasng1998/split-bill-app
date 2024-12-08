package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import splitbill.bean.UserBean;
import splitbill.bean.UserExpensesGroupBean;
import splitbill.dao.UserExpensesGroupRepository;
import splitbill.dao.UserRepository;
import splitbill.model.ExpensesGroupModel;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserExpensesGroupServiceImpl implements UserExpensesGroupService {

    private final UserExpensesGroupRepository userExpensesGroupRepository;
    private final UserRepository userRepository;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addUserToGroup(String username, int groupId) {

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        UserExpensesGroupBean userExpensesGroupBean = new UserExpensesGroupBean();
        userExpensesGroupBean.setUserId(userBean.getUserId());
        userExpensesGroupBean.setGroupId(groupId);
        userExpensesGroupBean.setJoinDate(new Date());
        userExpensesGroupRepository.save(userExpensesGroupBean);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ExpensesGroupModel> readGroups(String username) {

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        List<UserExpensesGroupBean> userExpensesGroupBeans = userExpensesGroupRepository.findByUserId(userBean.getUserId());
        log.info("userExpensesGroupBeans: {}", userExpensesGroupBeans);

        List<ExpensesGroupModel> expensesGroupModels = new ArrayList<>();
        if (CollectionUtils.isEmpty(userExpensesGroupBeans)) {
            return expensesGroupModels;
        }

        for (UserExpensesGroupBean userExpensesGroupBean: userExpensesGroupBeans) {
            ExpensesGroupModel expensesGroupModel = new ExpensesGroupModel();
            BeanUtils.copyProperties(userExpensesGroupBean.getExpensesGroupBean(), expensesGroupModel);
            log.info("userExpensesGroupBean.getExpensesGroupBean(): {}", userExpensesGroupBean.getExpensesGroupBean());
            log.info("expensesGroupModel: {}", expensesGroupModel);
            expensesGroupModels.add(expensesGroupModel);
        }

        return expensesGroupModels;
    }
}
