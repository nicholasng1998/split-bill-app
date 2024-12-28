package splitbill.model;

import lombok.Data;

import java.util.List;

@Data
public class GroupDetailsModel {

    List<UserModel> userModels;
    List<ExpensesDetailsModel> expensesDetailsModels;
    boolean isHost;

}
