package splitbill.service;

import splitbill.model.ExpensesGroupModel;
import splitbill.model.GroupDetailsModel;

public interface ExpensesGroupService {

    void createGroup(ExpensesGroupModel expensesGroupModel);


    void updateGroupStatusToStarted(int groupId);


    void updateGroupStatusToClosed(int groupId);

    GroupDetailsModel readGroupDetails(int groupId);

}
