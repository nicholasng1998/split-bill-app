class TransactionHistoryModel {
  int transactionId;
  int userId;
  String transactionType;
  DateTime transactionDate;
  double transactionAmount; // BigDecimal in Java is a double in Dart
  int groupId;

  // Constructor
  TransactionHistoryModel({
    required this.transactionId,
    required this.userId,
    required this.transactionType,
    required this.transactionDate,
    required this.transactionAmount,
    required this.groupId,
  });

  // Factory method to create an instance from a JSON object
  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryModel(
      transactionId: json['transactionId'],
      userId: json['userId'],
      transactionType: json['transactionType'],
      transactionDate: DateTime.parse(json['transactionDate']),
      transactionAmount: json['transactionAmount'].toDouble(),
      groupId: json['groupId'],
    );
  }

  // Method to convert the instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'userId': userId,
      'transactionType': transactionType,
      'transactionDate': transactionDate.toIso8601String(),
      'transactionAmount': transactionAmount,
      'groupId': groupId,
    };
  }

  // Optional: Override toString for better readability
  @override
  String toString() {
    return 'TransactionHistoryModel(transactionId: $transactionId, userId: $userId, transactionType: $transactionType, transactionDate: $transactionDate, transactionAmount: $transactionAmount, groupId: $groupId)';
  }
}
