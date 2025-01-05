package org.splitbill.feign;

import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.P2PSetupModel;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@FeignClient(name = "P2P-SETUP", url = "http://localhost:8081", path = "/v1/p2p-setup")
public interface P2PSetupFeignService {

    @PostMapping(value = "/apply")
    CommonResponseModel applyP2P(@RequestBody P2PSetupModel p2PSetupModel);

    @GetMapping(value = "/find-all")
    List<P2PSetupModel> findAll();
}
