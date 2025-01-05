package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import splitbill.bean.ExpensesDetailsBean;
import splitbill.bean.UserBean;
import splitbill.dao.ExpensesDetailsRepository;
import splitbill.dao.UserRepository;
import splitbill.model.ExpensesDetailsModel;
import splitbill.util.AuthUtil;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExpensesDetailsServiceImpl implements ExpensesDetailsService {

    private final ExpensesDetailsRepository expensesDetailsRepository;
    private final UserRepository userRepository;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addItemization(ExpensesDetailsModel expensesDetailsModel) {
        String username = AuthUtil.getUsername();

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        ExpensesDetailsBean expensesDetailsBean = new ExpensesDetailsBean();
        BeanUtils.copyProperties(expensesDetailsModel, expensesDetailsBean);
        expensesDetailsBean.setCreatedBy(userBean.getUserId());

        log.info("expensesDetailsBean: {}", expensesDetailsBean);
        expensesDetailsRepository.save(expensesDetailsBean);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ExpensesDetailsModel> readItemization(int groupId) {
        String username = AuthUtil.getUsername();

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        List<ExpensesDetailsBean> expensesDetailsBeans = expensesDetailsRepository.findByGroupId(groupId);
        log.info("expensesDetailsBeans: {}", expensesDetailsBeans);

        if (CollectionUtils.isEmpty(expensesDetailsBeans)) {
            return null;
        }

        List<ExpensesDetailsModel> expensesDetailsModels = new ArrayList<>();
        expensesDetailsBeans.forEach(bean -> {
            ExpensesDetailsModel expensesDetailsModel = new ExpensesDetailsModel();
            BeanUtils.copyProperties(bean, expensesDetailsModel);

            UserBean eachUser = userRepository.findById(bean.getCreatedBy()).orElse(null);
            if (eachUser != null) {
                expensesDetailsModel.setCreatedByName(eachUser.getUsername());
            }
            expensesDetailsModels.add(expensesDetailsModel);
        });

        log.info("expensesDetailsModels: {}", expensesDetailsModels);
        return expensesDetailsModels;
    }

    @Override
    @Transactional(readOnly = true)
    public List<ExpensesDetailsModel> readAllItemization(int groupId) {
        List<ExpensesDetailsBean> expensesDetailsBeans = expensesDetailsRepository.findByGroupId(groupId);
        log.info("expensesDetailsBeans: {}", expensesDetailsBeans);

        if (CollectionUtils.isEmpty(expensesDetailsBeans)) {
            return null;
        }

        List<ExpensesDetailsModel> expensesDetailsModels = new ArrayList<>();
        expensesDetailsBeans.forEach(bean -> {
            ExpensesDetailsModel expensesDetailsModel = new ExpensesDetailsModel();
            BeanUtils.copyProperties(bean, expensesDetailsModel);
            expensesDetailsModels.add(expensesDetailsModel);
        });

        log.info("expensesDetailsModels: {}", expensesDetailsModels);
        return expensesDetailsModels;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateItemization(ExpensesDetailsModel expensesDetailsModel) {
        String username = AuthUtil.getUsername();

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        ExpensesDetailsBean expensesDetailsBean = expensesDetailsRepository.findById(expensesDetailsModel.getDetailsId()).orElse(null);
        if (expensesDetailsBean == null) {
            throw new InternalError("not.found");
        }

        expensesDetailsBean.setAmount(expensesDetailsModel.getAmount());
        expensesDetailsBean.setItemName(expensesDetailsModel.getItemName());
        expensesDetailsBean.setUpdatedDate(new Date());

        log.info("expensesDetailsBean: {}", expensesDetailsBean);
        expensesDetailsRepository.save(expensesDetailsBean);
    }
}
