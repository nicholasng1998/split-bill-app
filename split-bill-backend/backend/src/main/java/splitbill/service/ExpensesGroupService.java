package splitbill.service;

import splitbill.model.ExpensesGroupModel;

import java.util.List;

public interface ExpensesGroupService {

    void createGroup(ExpensesGroupModel expensesGroupModel);


    void updateGroupStatusToStarted(int groupId);


    void updateGroupStatusToClosed(int groupId);

}
