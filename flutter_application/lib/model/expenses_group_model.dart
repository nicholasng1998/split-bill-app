import 'dart:convert';

class ExpensesGroupModel {
  final int groupId;
  final String groupName;
  final double totalExpenses;
  final double paidAmount;
  final double outstandingAmount;
  String status;
  final int host;
  final DateTime dueDate;

  // Constructor
  ExpensesGroupModel({
    required this.groupId,
    required this.groupName,
    required this.totalExpenses,
    required this.paidAmount,
    required this.outstandingAmount,
    required this.status,
    required this.host,
    required this.dueDate,
  });

  // Factory constructor to create an instance from JSON
  factory ExpensesGroupModel.fromJson(Map<String, dynamic> json) {
    return ExpensesGroupModel(
      groupId: json['groupId'],
      groupName: json['groupName'],
      totalExpenses:
          (json['totalExpenses'] as num).toDouble(), // BigDecimal -> double
      paidAmount:
          (json['paidAmount'] as num).toDouble(), // BigDecimal -> double
      outstandingAmount:
          (json['outstandingAmount'] as num).toDouble(), // BigDecimal -> double
      status: json['status'],
      host: json['host'],
      dueDate: DateTime.parse(json['dueDate']), // Convert to DateTime
    );
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'groupName': groupName,
      'totalExpenses': totalExpenses,
      'paidAmount': paidAmount,
      'outstandingAmount': outstandingAmount,
      'status': status,
      'host': host,
      'dueDate': dueDate.toIso8601String(), // Convert DateTime to string
    };
  }
}
