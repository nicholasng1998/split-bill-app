package splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import splitbill.model.CommonResponseModel;
import splitbill.model.UserModel;
import splitbill.service.UserService;

@Slf4j
@RestController
@RequestMapping("/v1/user")
@RequiredArgsConstructor
public class UserRestController {

    private final UserService userService;

    @PostMapping(value = "/create")
    public ResponseEntity<CommonResponseModel> createUser(@RequestBody UserModel userModel) {
        try {
            userService.createUser(userModel);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(new CommonResponseModel("Fail"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new CommonResponseModel("Success"), HttpStatus.OK);
    }

    @GetMapping(value = "/get")
    public ResponseEntity<UserModel> getUser(@RequestParam String username) {
        UserModel responseModel = new UserModel();
        try {
            responseModel = userService.readUserByUsername(username);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(responseModel, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(responseModel, HttpStatus.OK);
    }

}
