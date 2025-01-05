package splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import splitbill.model.CommonResponseModel;
import splitbill.model.TransactionHistoryModel;
import splitbill.service.TransactionHistoryService;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/v1/transaction-history")
@RequiredArgsConstructor
public class TransactionHistoryRestController {

    private final TransactionHistoryService transactionHistoryService;

    @PostMapping(value = "/create")
    public ResponseEntity<CommonResponseModel> create(@RequestBody TransactionHistoryModel transactionHistoryModel) {
        try {
            log.info("TransactionHistoryModel: {}", transactionHistoryModel);
            transactionHistoryService.makePayment(transactionHistoryModel);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(new CommonResponseModel("Fail"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new CommonResponseModel("Success"), HttpStatus.OK);
    }

    @GetMapping(value = "/read")
    public ResponseEntity<List<TransactionHistoryModel>> read(@RequestBody TransactionHistoryModel transactionHistoryModel) {
        List<TransactionHistoryModel> transactionHistoryModels = new ArrayList<>();
        try {
            transactionHistoryModels = transactionHistoryService.readTransactionHistory(transactionHistoryModel);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(transactionHistoryModels, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(transactionHistoryModels, HttpStatus.OK);
    }
}
