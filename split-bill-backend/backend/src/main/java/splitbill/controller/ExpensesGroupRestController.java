package splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import splitbill.model.CommonResponseModel;
import splitbill.model.ExpensesGroupModel;
import splitbill.model.GroupDetailsModel;
import splitbill.service.ExpensesGroupService;

@Slf4j
@RestController
@RequestMapping("/v1/expenses-group")
@RequiredArgsConstructor
public class ExpensesGroupRestController {

    private final ExpensesGroupService expensesGroupService;

    @PostMapping(value = "/create")
    public ResponseEntity<CommonResponseModel> createGroup(@RequestBody ExpensesGroupModel expensesGroupModel) {
        try {
            expensesGroupService.createGroup(expensesGroupModel);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(new CommonResponseModel("Fail"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new CommonResponseModel("Success"), HttpStatus.OK);
    }

    @PostMapping(value = "/update-to-started")
    public ResponseEntity<CommonResponseModel> updateGroupStatusToStarted(@RequestParam int groupId) {
        try {
            expensesGroupService.updateGroupStatusToStarted(groupId);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(new CommonResponseModel("Fail"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new CommonResponseModel("Success"), HttpStatus.OK);
    }

    @PostMapping(value = "/update-to-closed")
    public ResponseEntity<CommonResponseModel> updateGroupStatusToClosed(@RequestParam int groupId) {
        try {
            expensesGroupService.updateGroupStatusToClosed(groupId);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(new CommonResponseModel("Fail"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new CommonResponseModel("Success"), HttpStatus.OK);
    }

    @GetMapping(value = "/get-group-details")
    public ResponseEntity<GroupDetailsModel> getGroupDetails(@RequestParam int groupId) {
        GroupDetailsModel groupDetailsModel = new GroupDetailsModel();
        try {
            groupDetailsModel = expensesGroupService.readGroupDetails(groupId);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(groupDetailsModel, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(groupDetailsModel, HttpStatus.OK);
    }

}
