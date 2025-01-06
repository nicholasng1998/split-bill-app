import 'package:flutter_application/model/transaction_history_model.dart';

import 'user_model.dart'; // Import the UserModel class
import 'expenses_details_model.dart'; // Import the ExpensesDetailsModel class

class GroupDetailsModel {
  final List<UserModel> userModels;
  final List<ExpensesDetailsModel> expensesDetailsModels;
  final List<TransactionHistoryModel> transactionHistoryModels;
  final bool isHost;

  GroupDetailsModel({
    required this.userModels,
    required this.expensesDetailsModels,
    required this.transactionHistoryModels,
    required this.isHost,
  });

  // Factory method to create an instance from JSON
  factory GroupDetailsModel.fromJson(Map<String, dynamic> json) {
    var userList = json['userModels'] as List?;
    var expensesList = json['expensesDetailsModels'] as List?;
    var transactionHistoryList = json['transactionHistoryModels'] as List?;

    return GroupDetailsModel(
      userModels: userList != null
          ? userList.map((user) => UserModel.fromJson(user)).toList()
          : [],
      expensesDetailsModels: expensesList != null
          ? expensesList
              .map((expense) => ExpensesDetailsModel.fromJson(expense))
              .toList()
          : [],
      transactionHistoryModels: transactionHistoryList != null
          ? transactionHistoryList
              .map((transaction) =>
                  TransactionHistoryModel.fromJson(transaction))
              .toList()
          : [],
      isHost: json['host'],
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userModels': userModels.map((user) => user.toJson()).toList(),
      'expensesDetailsModels':
          expensesDetailsModels.map((expense) => expense.toJson()).toList(),
      'transactionHistoryModels': transactionHistoryModels
          .map((transaction) => transaction.toJson())
          .toList(),
      'isHost': isHost,
    };
  }
}
