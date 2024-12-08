package org.splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.splitbill.feign.ExpensesGroupFeignService;
import org.splitbill.feign.UserExpensesGroupFeignService;
import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.ExpensesGroupModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/user-expenses-group")
@RequiredArgsConstructor
public class UserExpensesGroupController {

    private final UserExpensesGroupFeignService userExpensesGroupFeignService;

    @GetMapping(value = "/read")
    public ResponseEntity<List<ExpensesGroupModel>> readUserExpensesGroup() {
        return new ResponseEntity<>(userExpensesGroupFeignService.readUserExpensesGroupModel(), HttpStatus.OK);
    }

    @PostMapping(value = "/add-user")
    public ResponseEntity<CommonResponseModel> addUser(@RequestParam String username, @RequestParam int groupId) {
        return new ResponseEntity<>(userExpensesGroupFeignService.addUser(username, groupId), HttpStatus.OK);
    }
}
