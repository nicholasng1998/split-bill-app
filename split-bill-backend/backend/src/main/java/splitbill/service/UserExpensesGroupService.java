package splitbill.service;

import splitbill.model.ExpensesGroupModel;

import java.util.List;

public interface UserExpensesGroupService {

    void addUserToGroup(String username, int groupId);

    List<ExpensesGroupModel> readGroups(String username);

}
