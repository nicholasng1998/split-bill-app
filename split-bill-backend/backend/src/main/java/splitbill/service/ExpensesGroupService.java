package splitbill.service;

import splitbill.model.ExpensesGroupModel;

import java.util.List;

public interface ExpensesGroupService {

    void createGroup(ExpensesGroupModel expensesGroupModel);

    void addUserToGroup();

    void updateGroupStatus();

    List<ExpensesGroupModel> readGroups(String username);

}
