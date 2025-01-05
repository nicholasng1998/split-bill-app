package splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import splitbill.model.CommonResponseModel;
import splitbill.model.P2PSetupModel;
import splitbill.service.P2PSetupService;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/v1/p2p-setup")
@RequiredArgsConstructor
public class P2PSetupRestController {

    private final P2PSetupService p2PSetupService;

    @PostMapping(value = "/apply")
    public ResponseEntity<CommonResponseModel> applyP2P(@RequestBody P2PSetupModel p2PSetupModel) {
        try {
            p2PSetupService.applyP2P(p2PSetupModel);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(new CommonResponseModel("Fail"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new CommonResponseModel("Success"), HttpStatus.OK);
    }

    @GetMapping(value = "/find-all")
    public ResponseEntity<List<P2PSetupModel>> findAll() {
        List<P2PSetupModel> p2PSetupModels = new ArrayList<>();
        try {
            p2PSetupModels = p2PSetupService.getAllActiveP2P();
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(p2PSetupModels, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(p2PSetupModels, HttpStatus.OK);
    }
}
