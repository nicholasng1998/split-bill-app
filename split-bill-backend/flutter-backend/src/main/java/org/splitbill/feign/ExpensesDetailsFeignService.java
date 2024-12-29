package org.splitbill.feign;

import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.ExpensesDetailsModel;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@FeignClient(name = "EXPENSES-DETAILS", url = "http://localhost:8081", path = "/v1/expenses-details")
public interface ExpensesDetailsFeignService {

    @PostMapping(value = "/add")
    CommonResponseModel addItemization(@RequestBody ExpensesDetailsModel expensesDetailsModel);

    @GetMapping(value = "/read")
    List<ExpensesDetailsModel> readItemization(@RequestParam int groupId);

    @PostMapping(value = "/update")
    CommonResponseModel updateItemization(@RequestBody ExpensesDetailsModel expensesDetailsModel);


}
