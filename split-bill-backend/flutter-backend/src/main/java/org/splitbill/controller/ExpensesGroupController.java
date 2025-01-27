package org.splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.splitbill.feign.ExpensesGroupFeignService;
import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.ExpensesGroupModel;
import org.splitbill.model.GroupDetailsModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api/expenses-group")
@RequiredArgsConstructor
public class ExpensesGroupController {

    private final ExpensesGroupFeignService expensesGroupFeignService;

    @PostMapping(value = "/create")
    public ResponseEntity<CommonResponseModel> createGroup(@RequestBody ExpensesGroupModel expensesGroupModel) {
        log.info("expensesGroupModel: {}", expensesGroupModel);
        return new ResponseEntity<>(expensesGroupFeignService.createGroup(expensesGroupModel), HttpStatus.OK);
    }

    @PostMapping(value = "/update-to-started")
    public ResponseEntity<CommonResponseModel> updateGroupStatusToStarted(@RequestParam int groupId) {
        return new ResponseEntity<>(expensesGroupFeignService.updateGroupStatusToStarted(groupId), HttpStatus.OK);
    }

    @PostMapping(value = "/update-to-closed")
    public ResponseEntity<CommonResponseModel> updateGroupStatusToClosed(@RequestParam int groupId) {
        return new ResponseEntity<>(expensesGroupFeignService.updateGroupStatusToClosed(groupId), HttpStatus.OK);
    }

    @GetMapping(value = "/get-group-details")
    public ResponseEntity<GroupDetailsModel> getGroupDetails(@RequestParam int groupId) {
        return new ResponseEntity<>(expensesGroupFeignService.getGroupDetails(groupId), HttpStatus.OK);
    }

    @PostMapping(value = "/send-reminder")
    public ResponseEntity<CommonResponseModel> remindUser(@RequestParam int groupId) {
        return new ResponseEntity<>(expensesGroupFeignService.remindUser(groupId), HttpStatus.OK);
    }
}
