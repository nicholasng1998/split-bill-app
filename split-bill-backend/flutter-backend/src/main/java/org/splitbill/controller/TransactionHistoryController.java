package org.splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.splitbill.feign.TransactionHistoryFeignService;
import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.TransactionHistoryModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/transaction-history")
@RequiredArgsConstructor
public class TransactionHistoryController {

    private final TransactionHistoryFeignService transactionHistoryFeignService;

    @PostMapping(value = "/create")
    public ResponseEntity<CommonResponseModel> create(@RequestBody TransactionHistoryModel transactionHistoryModel) {
        log.info("TransactionHistoryModel: {}", transactionHistoryModel);
        return new ResponseEntity<>(transactionHistoryFeignService.create(transactionHistoryModel), HttpStatus.OK);
    }

    @GetMapping(value = "/read")
    public ResponseEntity<List<TransactionHistoryModel>> read(@RequestParam int groupId) {
        return new ResponseEntity<>(transactionHistoryFeignService.read(groupId), HttpStatus.OK);
    }

}
