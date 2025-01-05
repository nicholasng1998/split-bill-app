package splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import splitbill.model.ActivityModel;
import splitbill.service.ActivityService;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/v1/activity")
@RequiredArgsConstructor
public class ActivityRestController {

    private final ActivityService activityService;

    @GetMapping(value = "/read")
    public ResponseEntity<List<ActivityModel>> readActivities() {
        List<ActivityModel> activityModels = new ArrayList<>();
        try {
            activityModels = activityService.readActivities();
        } catch (Exception e) {
            log.error("error: ", e);
            return new ResponseEntity<>(activityModels, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(activityModels, HttpStatus.OK);
    }
}
