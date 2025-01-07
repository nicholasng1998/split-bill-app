package splitbill.service;

import splitbill.model.ActivityModel;

import java.util.List;

public interface ActivityService {

    void saveActivity(String activityType, String action);

    void saveActivityForUser(String activityType, String action, int userId);


    List<ActivityModel> readActivities();
}
