import 'dart:convert';

class P2PTransactionModel {
  int p2pTransactionId;
  int userId;
  int merchantId;
  double lendAmount; // Use double instead of BigDecimal
  double paidAmount; // Use double instead of BigDecimal
  String status;
  DateTime settlementDate;

  // Constructor
  P2PTransactionModel({
    required this.p2pTransactionId,
    required this.userId,
    required this.merchantId,
    required this.lendAmount,
    required this.paidAmount,
    required this.status,
    required this.settlementDate,
  });

  // From JSON constructor to parse a JSON object into an instance of P2PTransactionModel
  factory P2PTransactionModel.fromJson(Map<String, dynamic> json) {
    return P2PTransactionModel(
      p2pTransactionId: json['p2pTransactionId'],
      userId: json['userId'],
      merchantId: json['merchantId'],
      lendAmount: json['lendAmount'].toDouble(), // Convert to double
      paidAmount: json['paidAmount'].toDouble(), // Convert to double
      status: json['status'],
      settlementDate: DateTime.parse(json['settlementDate']),
    );
  }

  // Method to convert an instance of P2PTransactionModel to JSON format
  Map<String, dynamic> toJson() {
    return {
      'p2pTransactionId': p2pTransactionId,
      'userId': userId,
      'merchantId': merchantId,
      'lendAmount': lendAmount, // Stored as double
      'paidAmount': paidAmount, // Stored as double
      'status': status,
      'settlementDate': settlementDate.toIso8601String(),
    };
  }
}
