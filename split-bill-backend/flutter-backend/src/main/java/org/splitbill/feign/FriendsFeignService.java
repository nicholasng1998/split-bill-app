package org.splitbill.feign;

import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.UserModel;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@FeignClient(name = "FRIENDS", url = "http://localhost:8081", path = "/v1/friends")
public interface FriendsFeignService {

    @PostMapping(value = "/add")
    CommonResponseModel addFriend(@RequestParam String email);

    @GetMapping(value = "/get")
    List<UserModel> getFriends();
}
