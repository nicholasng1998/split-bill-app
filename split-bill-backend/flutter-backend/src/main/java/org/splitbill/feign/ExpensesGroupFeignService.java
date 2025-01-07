package org.splitbill.feign;

import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.ExpensesGroupModel;
import org.splitbill.model.GroupDetailsModel;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(name = "EXPENSES-GROUP", url = "http://localhost:8081", path = "/v1/expenses-group")
public interface ExpensesGroupFeignService {

    @PostMapping(value = "/create")
    CommonResponseModel createGroup(@RequestBody ExpensesGroupModel expensesGroupModel);

    @PostMapping(value = "/update-to-started")
    CommonResponseModel updateGroupStatusToStarted(@RequestParam int groupId);

    @PostMapping(value = "/update-to-closed")
    CommonResponseModel updateGroupStatusToClosed(@RequestParam int groupId);

    @GetMapping(value = "/get-group-details")
    GroupDetailsModel getGroupDetails(@RequestParam int groupId);

    @PostMapping(value = "/send-reminder")
    CommonResponseModel remindUser(@RequestParam int groupId);
}
