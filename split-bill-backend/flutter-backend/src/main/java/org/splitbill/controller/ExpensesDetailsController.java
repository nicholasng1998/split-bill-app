package org.splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.splitbill.feign.ExpensesDetailsFeignService;
import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.ExpensesDetailsModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/itemization")
@RequiredArgsConstructor
public class ExpensesDetailsController {

    private final ExpensesDetailsFeignService expensesDetailsFeignService;

    @PostMapping(value = "/add")
    public ResponseEntity<CommonResponseModel> addItemization(@RequestBody ExpensesDetailsModel expensesDetailsModel) {
        return new ResponseEntity<>(expensesDetailsFeignService.addItemization(expensesDetailsModel), HttpStatus.OK);
    }

    @GetMapping(value = "/read")
    public ResponseEntity<List<ExpensesDetailsModel>> readItemization(@RequestParam int groupId) {
        return new ResponseEntity<>(expensesDetailsFeignService.readItemization(groupId), HttpStatus.OK);
    }

    @PostMapping(value = "/update")
    public ResponseEntity<CommonResponseModel> updateItemization(@RequestBody ExpensesDetailsModel expensesDetailsModel) {
        return new ResponseEntity<>(expensesDetailsFeignService.updateItemization(expensesDetailsModel), HttpStatus.OK);
    }

}
