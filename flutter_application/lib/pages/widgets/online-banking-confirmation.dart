import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/expenses_group_model.dart';
import '../../model/transaction_history_model.dart';
import '../../services/transaction_history_service.dart';
import '../../theme.dart';

class OnlineBankingConfirmationScreen extends StatefulWidget {
  @override
  OnlineBankingConfirmationState createState() =>
      OnlineBankingConfirmationState();
}

class OnlineBankingConfirmationState
    extends State<OnlineBankingConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    final TransactionHistoryModel transactionHistoryModel =
        arguments[0] as TransactionHistoryModel;
    final ExpensesGroupModel expensesGroupModel =
        arguments[1] as ExpensesGroupModel;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                CustomTheme.loginGradientStart,
                CustomTheme.loginGradientEnd
              ],
            ),
          ),
          child: AppBar(
            title: Text(
              'Online Banking Confirmation',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            header(),
            amount(),
            myrAmount(transactionHistoryModel.transactionAmount),
            submitButton(transactionHistoryModel, expensesGroupModel),
          ],
        ),
      )),
    );
  }

  Widget submitButton(TransactionHistoryModel transactionHistoryModel,
      ExpensesGroupModel expensesGroupModel) {
    return ElevatedButton(
      onPressed: () {
        create(
            context,
            transactionHistoryModel.transactionType,
            transactionHistoryModel.transactionAmount,
            transactionHistoryModel.groupId);
        showPaymentSuccessDialog(context, "Success",
            "Transaction Made Successfully!", expensesGroupModel);
      },
      child: Text("Approve via SecureTAC",
          style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              fontSize: 16.0,
              color: Colors.white)),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 23.0),
      child: Center(
        child: Text(
          "Confirmation",
          style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              fontSize: 25.0,
              color: Colors.black),
        ),
      ),
    );
  }

  Widget myrAmount(double amount) {
    String amountStr = amount.toStringAsFixed(2);

    return Padding(
      padding: const EdgeInsets.only(bottom: 23.0),
      child: Center(
        child: Text(
          "MYR ${amountStr}",
          style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              fontSize: 25.0,
              color: Colors.black),
        ),
      ),
    );
  }

  Widget amount() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 23.0),
      child: Center(
        child: Text(
          "Amount",
          style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              fontSize: 16.0,
              color: Colors.black),
        ),
      ),
    );
  }

  void showPaymentSuccessDialog(BuildContext context, String title, String text,
      ExpensesGroupModel expensesGroupModel) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.greenAccent,
                size: 50.0,
              ),
              SizedBox(height: 16.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () => {
                  Navigator.pop(context),
                  Navigator.pushNamed(context, "/groupDetailsScreen",
                      arguments: expensesGroupModel),
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPaymentErrorDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.redAccent,
                size: 50.0,
              ),
              SizedBox(height: 16.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
