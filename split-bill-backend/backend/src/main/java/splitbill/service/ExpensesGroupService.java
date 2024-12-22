package splitbill.service;

import splitbill.model.ExpensesGroupModel;

public interface ExpensesGroupService {

    void createGroup(ExpensesGroupModel expensesGroupModel);


    void updateGroupStatusToStarted(int groupId);


    void updateGroupStatusToClosed(int groupId);

}
