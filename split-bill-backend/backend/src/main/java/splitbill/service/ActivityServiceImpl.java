package splitbill.service;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import splitbill.bean.ActivityBean;
import splitbill.bean.UserBean;
import splitbill.dao.ActivityRepository;
import splitbill.dao.UserRepository;
import splitbill.model.ActivityModel;
import splitbill.util.AuthUtil;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ActivityServiceImpl implements ActivityService {


    private final UserRepository userRepository;
    private final ActivityRepository activityRepository;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveActivity(String activityType, String action) {
        String username = AuthUtil.getUsername();

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        ActivityBean activityBean = new ActivityBean();
        activityBean.setUserId(userBean.getUserId());
        activityBean.setActivityType(activityType);
        activityBean.setAction(action);
        activityRepository.save(activityBean);
        log.info("activityBean: {}", activityBean);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ActivityModel> readActivities() {
        String username = AuthUtil.getUsername();

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        List<ActivityBean> activityBeans = activityRepository.findAllByUserIdOrderByCreatedDateDesc(userBean.getUserId());

        if (CollectionUtils.isEmpty(activityBeans)) {
            return null;
        }

        List<ActivityModel> activityModels = new ArrayList<>();
        activityBeans.forEach(bean -> {
            ActivityModel activityModel = new ActivityModel();
            BeanUtils.copyProperties(bean, activityModel);
            activityModels.add(activityModel);
        });

        return activityModels;
    }
}
