package org.splitbill.feign;

import org.splitbill.model.UserModel;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(name = "USER", url = "http://localhost:8081", path = "/v1/user")
public interface UserFeignService {

    @GetMapping(value = "/get")
    UserModel getUser(@RequestParam String username);

}