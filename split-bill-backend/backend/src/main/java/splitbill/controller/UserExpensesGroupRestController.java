package splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import splitbill.model.CommonResponseModel;
import splitbill.model.ExpensesGroupModel;
import splitbill.model.UserModel;
import splitbill.service.ExpensesGroupService;
import splitbill.service.UserExpensesGroupService;
import splitbill.util.AuthUtil;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/v1/user-expenses-group")
@RequiredArgsConstructor
public class UserExpensesGroupRestController {

    private final UserExpensesGroupService userExpensesGroupService;

    @GetMapping(value = "/read")
    public ResponseEntity<List<ExpensesGroupModel>> readUserGroup() {
        List<ExpensesGroupModel> responseModel = new ArrayList<>();
        try {
            return new ResponseEntity<>(userExpensesGroupService.readGroups(AuthUtil.getUsername()), HttpStatus.OK);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(responseModel, HttpStatus.BAD_REQUEST);
        }
    }
}
