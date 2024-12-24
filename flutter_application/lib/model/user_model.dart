class UserModel {
  final int userId;
  final String identityNo;
  final String mobileNo;
  final String username;
  final String password;

  // Constructor
  UserModel({
    required this.userId,
    required this.identityNo,
    required this.mobileNo,
    required this.username,
    required this.password,
  });

  // Convert a JSON map to a UserModel object (fromJson)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      identityNo: json['identityNo'],
      mobileNo: json['mobileNo'],
      username: json['username'],
      password: json['password'],
    );
  }

  // Convert a UserModel object to a JSON map (toJson)
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'identityNo': identityNo,
      'mobileNo': mobileNo,
      'username': username,
      'password': password,
    };
  }
}
