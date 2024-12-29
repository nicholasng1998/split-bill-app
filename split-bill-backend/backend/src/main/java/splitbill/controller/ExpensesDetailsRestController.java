package splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import splitbill.model.CommonResponseModel;
import splitbill.model.ExpensesDetailsModel;
import splitbill.service.ExpensesDetailsService;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/v1/expenses-details")
@RequiredArgsConstructor
public class ExpensesDetailsRestController {

    private final ExpensesDetailsService expensesDetailsService;

    @PostMapping(value = "/add")
    public ResponseEntity<CommonResponseModel> addItemization(@RequestBody ExpensesDetailsModel expensesDetailsModel) {
        try {
            expensesDetailsService.addItemization(expensesDetailsModel);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(new CommonResponseModel("Fail"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new CommonResponseModel("Success"), HttpStatus.OK);
    }

    @GetMapping(value = "/read")
    public ResponseEntity<List<ExpensesDetailsModel>> readItemization(@RequestParam int groupId) {
        List<ExpensesDetailsModel> expensesDetailsModels = new ArrayList<>();
        try {
            expensesDetailsModels = expensesDetailsService.readItemization(groupId);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(expensesDetailsModels, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(expensesDetailsModels, HttpStatus.OK);
    }

    @PostMapping(value = "/update")
    public ResponseEntity<CommonResponseModel> updateItemization(@RequestBody ExpensesDetailsModel expensesDetailsModel) {
        try {
            expensesDetailsService.updateItemization(expensesDetailsModel);
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(new CommonResponseModel("Fail"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new CommonResponseModel("Success"), HttpStatus.OK);
    }
}
