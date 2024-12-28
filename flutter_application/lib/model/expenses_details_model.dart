import 'dart:convert';

// ExpensesDetailsModel class
class ExpensesDetailsModel {
  final int detailsId;
  final double amount; // Using double for BigDecimal
  final String itemName;
  final int createdBy;
  final int groupId;

  // Constructor
  ExpensesDetailsModel({
    required this.detailsId,
    required this.amount,
    required this.itemName,
    required this.createdBy,
    required this.groupId,
  });

  // Factory method to create an instance from JSON
  factory ExpensesDetailsModel.fromJson(Map<String, dynamic> json) {
    return ExpensesDetailsModel(
      detailsId: json['detailsId'],
      amount: json['amount'].toDouble(), // Convert from BigDecimal to double
      itemName: json['itemName'],
      createdBy: json['createdBy'],
      groupId: json['groupId'],
    );
  }

  // Method to convert the object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'detailsId': detailsId,
      'amount': amount,
      'itemName': itemName,
      'createdBy': createdBy,
      'groupId': groupId,
    };
  }
}
