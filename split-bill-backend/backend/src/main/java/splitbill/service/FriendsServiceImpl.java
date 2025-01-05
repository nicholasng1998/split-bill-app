package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import splitbill.bean.FriendsBean;
import splitbill.bean.UserBean;
import splitbill.bean.embedded.FriendsId;
import splitbill.dao.FriendsRepository;
import splitbill.dao.UserRepository;
import splitbill.model.UserModel;
import splitbill.util.AuthUtil;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class FriendsServiceImpl implements FriendsService {

    private final FriendsRepository friendsRepository;
    private final UserRepository userRepository;
    private final ActivityService activityService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addFriend(String email) {
        String username = AuthUtil.getUsername();

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        UserBean friendUserBean = userRepository.findByUsername(email).orElse(null);
        if (friendUserBean == null) {
            throw new InternalError("user.not.found");
        }

        if (userBean.getUserId() == friendUserBean.getUserId()) {
            throw new InternalError("same.user");
        }

        FriendsId friendsId = new FriendsId();
        friendsId.setUserId(userBean.getUserId());
        friendsId.setFriendUserId(friendUserBean.getUserId());

        FriendsBean friendsBean = new FriendsBean();
        friendsBean.setId(friendsId);

        log.info("friendsBean: {}", friendsBean);
        friendsRepository.save(friendsBean);

        activityService.saveActivity("Add Friend", String.format("You have added %s.", friendUserBean.getUsername()));
    }

    @Override
    @Transactional(readOnly = true)
    public List<UserModel> getFriends() {
        String username = AuthUtil.getUsername();

        UserBean userBean = userRepository.findByUsername(username).orElse(null);
        if (userBean == null) {
            throw new InternalError("user.not.found");
        }

        List<FriendsBean> friendsBeans = friendsRepository.findAllByUserId(Arrays.asList(userBean.getUserId()));
        log.info("friendsBeans: {}", friendsBeans);
        if (CollectionUtils.isEmpty(friendsBeans)) {
            return null;
        }

        List<Integer> friendsUserId = friendsBeans.stream()
                .map(e -> e.getId().getFriendUserId())
                .collect(Collectors.toList());
        log.info("friendsUserId: {}", friendsUserId);

        List<UserBean> userBeans = userRepository.findByUserIdIn(friendsUserId);
        log.info("userBeans: {}", userBeans);

        List<UserModel> userModels = new ArrayList<>();
        userBeans.forEach(e -> {
            UserModel userModel = new UserModel();
            BeanUtils.copyProperties(e, userModel);
            userModels.add(userModel);
        });

        log.info("userModels: {}", userModels);
        return userModels;
    }
}
