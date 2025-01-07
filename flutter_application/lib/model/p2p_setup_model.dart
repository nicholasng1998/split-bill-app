import 'dart:convert';

class P2PSetupModel {
  int p2pSetupId;
  int userId;
  String status;
  double lendAmount;
  double remainingAmount;
  DateTime createdDate;
  DateTime updatedDate;
  String userIdName;

  // Constructor
  P2PSetupModel(
      {required this.p2pSetupId,
      required this.userId,
      required this.status,
      required this.lendAmount,
      required this.remainingAmount,
      required this.createdDate,
      required this.updatedDate,
      required this.userIdName});

  // From JSON constructor to parse a JSON object into an instance of P2PSetupModel
  factory P2PSetupModel.fromJson(Map<String, dynamic> json) {
    return P2PSetupModel(
      p2pSetupId: json['p2pSetupId'],
      userId: json['userId'],
      status: json['status'],
      lendAmount: json['lendAmount'].toDouble(),
      remainingAmount: json['remainingAmount'].toDouble(),
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
      userIdName: json['userIdName'],
    );
  }

  // Method to convert an instance of P2PSetupModel to JSON format
  Map<String, dynamic> toJson() {
    return {
      'p2pSetupId': p2pSetupId,
      'userId': userId,
      'status': status,
      'lendAmount': lendAmount
          .toString(), // Convert BigDecimal to String (if you are using BigDecimal in Flutter)
      'remainingAmount': remainingAmount
          .toString(), // Convert BigDecimal to String (if you are using BigDecimal in Flutter)
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate.toIso8601String(),
      'userIdName': userIdName,
    };
  }
}
