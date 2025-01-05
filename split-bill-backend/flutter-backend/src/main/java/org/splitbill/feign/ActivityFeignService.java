package org.splitbill.feign;

import org.splitbill.model.ActivityModel;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@FeignClient(name = "ACTIVITY", url = "http://localhost:8081", path = "/v1/activity")
public interface ActivityFeignService {

    @GetMapping(value = "/read")
    List<ActivityModel> readActivities();


}
