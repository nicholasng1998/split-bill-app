import 'package:flutter/material.dart';
import 'package:flutter_application/model/expenses_group_model.dart';
import 'package:flutter_application/model/transaction_history_model.dart';
import 'package:flutter_application/services/transaction_history_service.dart';
import '../../theme.dart';

class BecomeMerchantScreen extends StatefulWidget {
  @override
  BecomeMerchantScreenState createState() => BecomeMerchantScreenState();
}

class BecomeMerchantScreenState extends State<BecomeMerchantScreen> {
  // Controllers for each OTP digit box
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  TextEditingController otpController5 = TextEditingController();
  TextEditingController otpController6 = TextEditingController();

  bool isOTPComplete() {
    return otpController1.text.isNotEmpty &&
        otpController2.text.isNotEmpty &&
        otpController3.text.isNotEmpty &&
        otpController4.text.isNotEmpty &&
        otpController5.text.isNotEmpty &&
        otpController6.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
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
              'PIN Number Input',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOTPTextField(otpController1),
                    _buildOTPTextField(otpController2),
                    _buildOTPTextField(otpController3),
                    _buildOTPTextField(otpController4),
                    _buildOTPTextField(otpController5),
                    _buildOTPTextField(otpController6),
                  ],
                ),
                SizedBox(height: 20),
                submitButton()
              ],
            )),
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 23.0),
      child: Center(
        child: Text(
          "Enter PIN Number",
          style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              fontSize: 25.0,
              color: Colors.black),
        ),
      ),
    );
  }

  void onOTPComplete() {
    List<dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    final TransactionHistoryModel transactionHistoryModel =
        arguments[0] as TransactionHistoryModel;
    final ExpensesGroupModel expensesGroupModel =
        arguments[1] as ExpensesGroupModel;

    print(transactionHistoryModel);
    if (isOTPComplete()) {
      String otp = otpController1.text +
          otpController2.text +
          otpController3.text +
          otpController4.text +
          otpController5.text +
          otpController6.text;
      print("PIN entered: $otp");
      print(transactionHistoryModel);
      create(
          context,
          transactionHistoryModel.transactionType,
          transactionHistoryModel.transactionAmount,
          transactionHistoryModel.groupId);
      showPaymentSuccessDialog(context, "Success",
          "Transaction Made Successfully!", expensesGroupModel);
    } else {
      showPaymentErrorDialog(context, "Failed", "PIN is not complete yet!");
    }
  }

  Widget _buildOTPTextField(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: 50.0,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (isOTPComplete()) {
          onOTPComplete();
        } else {
          showPaymentErrorDialog(
              context, "Failed", "Please complete the PIN number!");
        }
      },
      child: Text("Submit PIN Number",
          style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              fontSize: 16.0,
              color: Colors.white)),
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
                  otpController1.clear(),
                  otpController2.clear(),
                  otpController3.clear(),
                  otpController4.clear(),
                  otpController5.clear(),
                  otpController6.clear(),
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
}
