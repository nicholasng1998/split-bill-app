package org.splitbill.feign;

import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.TransactionHistoryModel;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@FeignClient(name = "TRANSACTION-HISTORY", url = "http://localhost:8081", path = "/v1/transaction-history")
public interface TransactionHistoryFeignService {

    @PostMapping(value = "/create")
    CommonResponseModel create(@RequestBody TransactionHistoryModel transactionHistoryModel);

    @GetMapping(value = "/read")
    List<TransactionHistoryModel> read(@RequestParam int groupId);


}
