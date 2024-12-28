package org.splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.splitbill.feign.FriendsFeignService;
import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.UserModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/friends")
@RequiredArgsConstructor
public class FriendsController {

    private final FriendsFeignService friendsFeignService;

    @PostMapping(value = "/add")
    public ResponseEntity<CommonResponseModel> addFriend(@RequestParam String email) {
        log.info("Email: {}", email);
        return new ResponseEntity<>(friendsFeignService.addFriend(email), HttpStatus.OK);
    }

    @GetMapping(value = "/get")
    public ResponseEntity<List<UserModel>> getFriends() {
        return new ResponseEntity<>(friendsFeignService.getFriends(), HttpStatus.OK);
    }
}
