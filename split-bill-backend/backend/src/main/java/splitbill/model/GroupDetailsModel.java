package splitbill.model;

import lombok.Data;

import java.util.List;

@Data
public class GroupDetailsModel {

    List<UserModel> userModels;
    List<ExpensesDetailsModel> expensesDetailsModels;

    List<TransactionHistoryModel> transactionHistoryModels;

    ExpensesGroupModel expensesGroupModel;
    boolean isHost;

}
