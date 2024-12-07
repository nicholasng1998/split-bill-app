package splitbill.service;

import splitbill.model.UserModel;

public interface UserService {

    void createUser(UserModel userModel);

    UserModel readUserByUsername(String username);
}
