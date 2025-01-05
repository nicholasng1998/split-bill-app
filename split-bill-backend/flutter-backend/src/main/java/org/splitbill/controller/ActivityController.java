package org.splitbill.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.splitbill.feign.ActivityFeignService;
import org.splitbill.model.ActivityModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/activity")
@RequiredArgsConstructor
public class ActivityController {

    private final ActivityFeignService activityFeignService;

    @GetMapping(value = "/read")
    public ResponseEntity<List<ActivityModel>> readActivities() {
        return new ResponseEntity<>(activityFeignService.readActivities(), HttpStatus.OK);
    }
}
