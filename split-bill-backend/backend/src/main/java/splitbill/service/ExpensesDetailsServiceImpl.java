package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import splitbill.bean.ExpensesDetailsBean;
import splitbill.dao.ExpensesDetailsRepository;
import splitbill.model.ExpensesDetailsModel;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExpensesDetailsServiceImpl implements ExpensesDetailsService {

    private final ExpensesDetailsRepository expensesDetailsRepository;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addItemization(ExpensesDetailsModel expensesDetailsModel) {
        ExpensesDetailsBean expensesDetailsBean = new ExpensesDetailsBean();
        BeanUtils.copyProperties(expensesDetailsModel, expensesDetailsBean);
        log.info("expensesDetailsBean: {}", expensesDetailsBean);
        expensesDetailsRepository.save(expensesDetailsBean);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ExpensesDetailsModel> readItemization() {
        return null;
    }

    @Override
    public void updateItemization(int itemizationId, ExpensesDetailsModel expensesDetailsModel) {

    }
}
