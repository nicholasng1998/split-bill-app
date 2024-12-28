package splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import splitbill.model.CommonResponseModel;
import splitbill.model.UserModel;
import splitbill.service.FriendsService;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/v1/friends")
@RequiredArgsConstructor
public class FriendsRestController {

    private final FriendsService friendsService;

    @PostMapping(value = "/add")
    public ResponseEntity<CommonResponseModel> addFriend(@RequestParam String email) {
        try {
            friendsService.addFriend(email);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(new CommonResponseModel("Fail"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new CommonResponseModel("Success"), HttpStatus.OK);
    }

    @GetMapping(value = "/get")
    public ResponseEntity<List<UserModel>> getFriends() {
        List<UserModel> userModels = new ArrayList<>();
        try {
            userModels = friendsService.getFriends();
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(userModels, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(userModels, HttpStatus.OK);
    }

}
