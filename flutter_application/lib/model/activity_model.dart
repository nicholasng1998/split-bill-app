class ActivityModel {
  int activityId;
  int userId;
  String activityType;
  String action;
  DateTime createdDate;
  DateTime updatedDate;

  // Constructor
  ActivityModel({
    required this.activityId,
    required this.userId,
    required this.activityType,
    required this.action,
    required this.createdDate,
    required this.updatedDate,
  });

  // Factory constructor for creating an ActivityModel from JSON
  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      activityId: json['activityId'],
      userId: json['userId'],
      activityType: json['activityType'],
      action: json['action'],
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
    );
  }

  // Method for converting ActivityModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'activityId': activityId,
      'userId': userId,
      'activityType': activityType,
      'action': action,
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
