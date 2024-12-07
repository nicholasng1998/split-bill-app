package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import splitbill.bean.UserBean;
import splitbill.dao.UserRepository;
import splitbill.model.UserModel;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void createUser(UserModel userModel) {
        UserBean userBean = new UserBean();
        BeanUtils.copyProperties(userModel, userBean);
        log.info("userBean: {}", userBean);
        userRepository.save(userBean);
    }

    @Override
    @Transactional(readOnly = true)
    public UserModel readUserByUsername(String username) {
        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        UserModel userModel = new UserModel();
        if (userBean != null) {
            BeanUtils.copyProperties(userBean, userModel);
            log.info("userModel: {}", userModel);
        }
        return userModel;
    }
}
