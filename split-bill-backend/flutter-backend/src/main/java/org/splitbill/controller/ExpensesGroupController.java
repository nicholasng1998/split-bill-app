package org.splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.splitbill.feign.ExpensesGroupFeignService;
import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.ExpensesGroupModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/api/expenses-group")
@RequiredArgsConstructor
public class ExpensesGroupController {

    private final ExpensesGroupFeignService expensesGroupFeignService;

    @PostMapping(value = "/create")
    public ResponseEntity<CommonResponseModel> createGroup(@RequestBody ExpensesGroupModel expensesGroupModel) {
        return new ResponseEntity<>(expensesGroupFeignService.createGroup(expensesGroupModel), HttpStatus.OK);
    }
}
