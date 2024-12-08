package org.splitbill.feign;

import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.ExpensesGroupModel;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(name = "EXPENSES-GROUP", url = "http://localhost:8081", path = "/v1/expenses-group")
public interface ExpensesGroupFeignService {

    @PostMapping(value = "/create")
    CommonResponseModel createGroup(@RequestBody ExpensesGroupModel expensesGroupModel);
}
