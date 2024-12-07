package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import splitbill.bean.UserBean;
import splitbill.bean.UserExpensesGroupBean;
import splitbill.dao.UserExpensesGroupRepository;
import splitbill.dao.UserRepository;
import splitbill.util.AuthUtil;

import java.util.Date;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserExpensesGroupServiceImpl implements UserExpensesGroupService {

    private final UserExpensesGroupRepository userExpensesGroupRepository;
    private final UserRepository userRepository;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addUserToGroup(int userId, int groupId) {

        UserBean userBean = userRepository.findById(userId).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        UserExpensesGroupBean userExpensesGroupBean = new UserExpensesGroupBean();
        userExpensesGroupBean.setUserId(userBean.getUserId());
        userExpensesGroupBean.setGroupId(groupId);
        userExpensesGroupBean.setJoinDate(new Date());
        userExpensesGroupRepository.save(userExpensesGroupBean);
    }
}
