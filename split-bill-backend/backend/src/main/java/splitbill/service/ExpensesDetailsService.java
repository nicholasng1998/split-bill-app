package splitbill.service;

import splitbill.model.ExpensesDetailsModel;

import java.util.List;

public interface ExpensesDetailsService {

    void addItemization(ExpensesDetailsModel expensesDetailsModel);

    List<ExpensesDetailsModel> readItemization();
}
