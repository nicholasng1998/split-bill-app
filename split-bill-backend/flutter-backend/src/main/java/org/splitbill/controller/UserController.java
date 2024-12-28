package org.splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.splitbill.feign.UserFeignService;
import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.UserModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserController {

    private final UserFeignService userFeignService;

    @PostMapping(value = "/create")
    public ResponseEntity<CommonResponseModel> createUser(@RequestBody UserModel userModel) {
        log.info("UserModel: {}", userModel);
        return new ResponseEntity<>(userFeignService.createUser(userModel), HttpStatus.OK);
    }

}
