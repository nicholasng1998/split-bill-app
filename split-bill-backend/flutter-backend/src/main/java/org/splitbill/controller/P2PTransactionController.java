package org.splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.splitbill.feign.P2PTransactionFeignService;
import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.ExpensesGroupModel;
import org.splitbill.model.P2PTransactionModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/api/p2p-transaction")
@RequiredArgsConstructor
public class P2PTransactionController {

    private final P2PTransactionFeignService p2PTransactionFeignService;

    @PostMapping(value = "/create")
    public ResponseEntity<CommonResponseModel> createTransaction(@RequestBody P2PTransactionModel p2PTransactionModel) {
        return new ResponseEntity<>(p2PTransactionFeignService.create(p2PTransactionModel), HttpStatus.OK);
    }
}
