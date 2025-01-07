package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import splitbill.bean.ExpensesGroupBean;
import splitbill.bean.UserBean;
import splitbill.bean.UserExpensesGroupBean;
import splitbill.dao.ExpensesGroupRepository;
import splitbill.dao.UserExpensesGroupRepository;
import splitbill.dao.UserRepository;
import splitbill.model.ExpensesDetailsModel;
import splitbill.model.ExpensesGroupModel;
import splitbill.model.UserModel;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserExpensesGroupServiceImpl implements UserExpensesGroupService {

    private final UserExpensesGroupRepository userExpensesGroupRepository;
    private final UserRepository userRepository;
    private final ActivityService activityService;

    private final ExpensesGroupRepository expensesGroupRepository;

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

        ExpensesGroupBean expensesGroupBean = expensesGroupRepository.getOne(groupId);
        log.info("expensesGroupBean: {}", expensesGroupBean);
        if (username != userBean.getUsername()) {
            activityService.saveActivity("Add User To Group", String.format("You have added %s to %s.", username, expensesGroupBean.getGroupName()));
        } else {
            activityService.saveActivity("Create Group", String.format("You have created a group named %s.", expensesGroupBean.getGroupName()));
        }

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

    @Override
    @Transactional(readOnly = true)
    public List<UserModel> readAllUsersFromGroup(int groupId) {
        List<UserExpensesGroupBean> userExpensesGroupBeans = userExpensesGroupRepository.findByGroupId(groupId);
        log.info("userExpensesGroupBeans: {}", userExpensesGroupBeans);

        if (CollectionUtils.isEmpty(userExpensesGroupBeans)) {
            return null;
        }

        List<Integer> userIds = userExpensesGroupBeans.stream()
                .map(UserExpensesGroupBean::getUserId)
                .collect(Collectors.toList());
        log.info("userIds: {}", userIds);

        if (CollectionUtils.isEmpty(userIds)) {
            return null;
        }

        List<UserBean> userBeans = userRepository.findByUserIdIn(userIds);
        log.info("userBeans: {}", userBeans);

        if (CollectionUtils.isEmpty(userBeans)) {
            return null;
        }

        List<UserModel> userModels = new ArrayList<>();
        userBeans.forEach(bean -> {
            UserModel userModel = new UserModel();
            BeanUtils.copyProperties(bean, userModel);
            userModels.add(userModel);
        });

        log.info("userModels: {}", userModels);
        return userModels;
    }

    @Override
    @Transactional(readOnly = true)
    public ExpensesGroupModel readGroup(int groupId) {

        ExpensesGroupBean expensesGroupBean = expensesGroupRepository.getOne(groupId);
        log.info("expensesGroupBean: {}", expensesGroupBean);
        ExpensesGroupModel expensesGroupModel = new ExpensesGroupModel();
        BeanUtils.copyProperties(expensesGroupBean, expensesGroupModel);
        return expensesGroupModel;
    }
}
