package splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import splitbill.model.CommonResponseModel;
import splitbill.model.ExpensesGroupModel;
import splitbill.service.ExpensesGroupService;

@Slf4j
@RestController
@RequestMapping("/v1/expenses-group")
@RequiredArgsConstructor
public class ExpensesGroupRestController {

    private final ExpensesGroupService expensesGroupService;

    @PostMapping(value = "/create")
    public ResponseEntity<CommonResponseModel> createGroup(@RequestBody ExpensesGroupModel expensesGroupModel) {
        try {
            expensesGroupService.createGroup(expensesGroupModel);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(new CommonResponseModel("Fail"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new CommonResponseModel("Success"), HttpStatus.OK);
    }



}
