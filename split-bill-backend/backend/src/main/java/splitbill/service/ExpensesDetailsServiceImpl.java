package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import splitbill.model.ExpensesDetailsModel;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExpensesDetailsServiceImpl implements ExpensesDetailsService {

    @Override
    public void addItemization(ExpensesDetailsModel expensesDetailsModel) {

    }

    @Override
    public List<ExpensesDetailsModel> readItemization() {
        return null;
    }
}
