class UserModel {
  final int userId;
  final String identityNo;
  final String mobileNo;
  final String username;
  final String password;
  final String bankAccountNumber;
  final String bankName;
  final String name;
  double totalOweAmount;
  double totalRemainingAmount;

  // Constructor
  UserModel({
    required this.userId,
    required this.identityNo,
    required this.mobileNo,
    required this.username,
    required this.password,
    required this.bankAccountNumber,
    required this.bankName,
    required this.name,
    required this.totalOweAmount,
    required this.totalRemainingAmount,
  });

  // Convert a JSON map to a UserModel object (fromJson)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      identityNo: json['identityNo'],
      mobileNo: json['mobileNo'],
      username: json['username'],
      password: json['password'],
      bankAccountNumber: json['bankAccountNumber'],
      bankName: json['bankName'],
      name: json['name'],
      totalOweAmount: json['totalOweAmount']?.toDouble(),
      totalRemainingAmount: json['totalRemainingAmount']?.toDouble(),
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
      'bankAccountNumber': bankAccountNumber,
      'bankName': bankName,
      'name': name,
      'totalOweAmount': totalOweAmount,
      'totalRemainingAmount': totalRemainingAmount,
    };
  }
}
