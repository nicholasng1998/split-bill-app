package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import splitbill.bean.BankAccountDetailsBean;
import splitbill.bean.UserBean;
import splitbill.dao.BankAccountDetailsRepository;
import splitbill.dao.UserRepository;
import splitbill.model.UserModel;

import java.util.Date;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final BankAccountDetailsRepository bankAccountDetailsRepository;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void createUser(UserModel userModel) {
        UserBean userBean = new UserBean();
        BeanUtils.copyProperties(userModel, userBean);
        userBean.setCreatedDate(new Date());
        userBean.setUpdatedDate(new Date());
        log.info("userBean: {}", userBean);
        userRepository.save(userBean);

        BankAccountDetailsBean bankAccountDetailsBean = new BankAccountDetailsBean();
        bankAccountDetailsBean.setBankName(userModel.getBankName());
        bankAccountDetailsBean.setBankAccountNumber(userModel.getBankAccountNumber());
        log.info("bankAccountDetailsBean: {}", bankAccountDetailsBean);
        bankAccountDetailsRepository.save(bankAccountDetailsBean);
    }

    @Override
    @Transactional(readOnly = true)
    public UserModel readUserByUsername(String username) {
        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        UserModel userModel = new UserModel();
        if (userBean != null) {
            BeanUtils.copyProperties(userBean, userModel);
            log.info("userModel: {}", userModel);

            BankAccountDetailsBean bankAccountDetailsBean = bankAccountDetailsRepository.findByUserId(userBean.getUserId()).orElse(null);
            if (bankAccountDetailsBean == null) {
                return userModel;
            }

            userModel.setBankName(bankAccountDetailsBean.getBankName());
            userModel.setBankAccountNumber(bankAccountDetailsBean.getBankAccountNumber());
            return userModel;
        }

        return userModel;
    }
}
