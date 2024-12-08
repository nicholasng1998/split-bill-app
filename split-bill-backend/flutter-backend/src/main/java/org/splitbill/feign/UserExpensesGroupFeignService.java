package org.splitbill.feign;

import org.splitbill.model.ExpensesGroupModel;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@FeignClient(name = "USER-EXPENSES-GROUP", url = "http://localhost:8081", path = "/v1/user-expenses-group")
public interface UserExpensesGroupFeignService {

    @GetMapping(value = "/read")
    List<ExpensesGroupModel> readUserExpensesGroupModel();
}
