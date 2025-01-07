package splitbill.service;

import splitbill.model.ExpensesGroupModel;
import splitbill.model.UserModel;

import java.util.List;

public interface UserExpensesGroupService {

    void addUserToGroup(String username, int groupId);

    List<ExpensesGroupModel> readGroups(String username);

    List<UserModel> readAllUsersFromGroup(int groupId);

    ExpensesGroupModel readGroup(int groupId);

}
