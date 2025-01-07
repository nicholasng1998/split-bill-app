package splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import splitbill.model.CommonResponseModel;
import splitbill.model.P2PSetupModel;
import splitbill.model.P2PTransactionModel;
import splitbill.service.P2PTransactionService;

@Slf4j
@RestController
@RequestMapping("/v1/p2p-transaction")
@RequiredArgsConstructor
public class P2PTransactionRestController {

    private final P2PTransactionService p2PTransactionService;

    @PostMapping(value = "/create")
    public ResponseEntity<CommonResponseModel> createTransaction(@RequestBody P2PTransactionModel p2PTransactionModel) {
        try {
            p2PTransactionService.createTransaction(p2PTransactionModel);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(new CommonResponseModel("Fail"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new CommonResponseModel("Success"), HttpStatus.OK);
    }
}
