package org.splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.splitbill.feign.P2PSetupFeignService;
import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.P2PSetupModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/p2p-setup")
@RequiredArgsConstructor
public class P2PSetupController {

    private final P2PSetupFeignService p2PSetupFeignService;

    @PostMapping(value = "/apply")
    public ResponseEntity<CommonResponseModel> applyP2P(@RequestBody P2PSetupModel p2PSetupModel) {
        log.info("p2PSetupModel: {}", p2PSetupModel);
        return new ResponseEntity<>(p2PSetupFeignService.applyP2P(p2PSetupModel), HttpStatus.OK);
    }

    @GetMapping(value = "/find-all")
    public ResponseEntity<List<P2PSetupModel>> findAll() {
        return new ResponseEntity<>(p2PSetupFeignService.findAll(), HttpStatus.OK);
    }
}
