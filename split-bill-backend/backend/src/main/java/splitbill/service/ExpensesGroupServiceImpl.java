package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import splitbill.model.ExpensesGroupModel;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExpensesGroupServiceImpl implements ExpensesGroupService {

    @Override
    public void createGroup(ExpensesGroupModel expensesGroupModel) {
        
    }

    @Override
    public void addUserToGroup() {

    }

    @Override
    public void updateGroupStatus() {

    }

    @Override
    public List<ExpensesGroupModel> readGroups(String username) {
        return null;
    }
}
