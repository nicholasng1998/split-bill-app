package splitbill.service;

import splitbill.model.CommonResponseModel;
import splitbill.model.UserModel;

import java.util.List;

public interface FriendsService {

    void addFriend(String email);

    List<UserModel> getFriends();

    CommonResponseModel removeFriend(int userId);

}
