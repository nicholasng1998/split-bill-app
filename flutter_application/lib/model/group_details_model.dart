import 'package:flutter_application/model/transaction_history_model.dart';
import 'package:flutter_application/model/expenses_group_model.dart';

import 'user_model.dart';
import 'expenses_details_model.dart';

class GroupDetailsModel {
  final List<UserModel> userModels;
  final List<ExpensesDetailsModel> expensesDetailsModels;
  final List<TransactionHistoryModel> transactionHistoryModels;
  final ExpensesGroupModel expensesGroupModel;
  final bool isHost;

  GroupDetailsModel({
    required this.userModels,
    required this.expensesDetailsModels,
    required this.transactionHistoryModels,
    required this.expensesGroupModel,
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
      expensesGroupModel:
          ExpensesGroupModel.fromJson(json['expensesGroupModel']),
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
      'expensesGroupModel': expensesDetailsModels,
      'isHost': isHost,
    };
  }
}
