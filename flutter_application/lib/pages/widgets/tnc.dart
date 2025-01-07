import 'package:flutter/material.dart';
import 'package:flutter_application/model/user_model.dart';
import 'package:flutter_application/pages/widgets/add-friends.dart';
import 'package:flutter_application/services/p2p_setup_service.dart';
import 'package:flutter_application/services/p2p_transaction_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/p2p_setup_model.dart';
import '../../services/friends_service.dart';
import '../../theme.dart';

class TncScreen extends StatefulWidget {
  @override
  TncScreenState createState() => TncScreenState();
}

class TncScreenState extends State<TncScreen> {
  final TextEditingController amountController = TextEditingController();
  bool _isAccepted = false;

  final String termsAndConditionsText = """
    1. Introduction
    These terms and conditions govern your use of this application...
    
    2. License
    We grant you a non-exclusive, non-transferable license to use this app...
    
    3. User Responsibilities
    You agree not to misuse the app for illegal purposes...
    
    4. Termination
    We reserve the right to terminate your account at any time...
    
    5. Limitation of Liability
    We are not liable for any damages caused by the use of this app...
    
    6. Governing Law
    These terms shall be governed by the laws of [Your Country]...
    
    7. Changes to Terms
    We may update these terms from time to time...
    
    8. Contact Information
    If you have any questions, please contact us at [email]...
    
    (Add more sections as required)
  """;

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
              'P2P Proposal',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: 300.0,
          height: 250.0,
          child: SingleChildScrollView(
            child: Card(
              elevation: 2.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: <Widget>[
                  lendAmountWidget(),
                  Container(
                    width: 250.0,
                    height: 1.0,
                    color: Colors.grey[400],
                  ),
                  tncAgreement(),
                  submitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget submitButton() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: CustomTheme.loginGradientStart,
            offset: Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
          BoxShadow(
            color: CustomTheme.loginGradientEnd,
            offset: Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
        ],
        gradient: LinearGradient(
            colors: <Color>[
              CustomTheme.loginGradientEnd,
              CustomTheme.loginGradientStart
            ],
            begin: FractionalOffset(0.2, 0.2),
            end: FractionalOffset(1.0, 1.0),
            stops: <double>[0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: MaterialButton(
        highlightColor: Colors.transparent,
        splashColor: CustomTheme.loginGradientEnd,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
          child: Text(
            'SUBMIT',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontFamily: 'WorkSansBold'),
          ),
        ),
        onPressed: () => {_proceed()},
      ),
    );
  }

  Widget tncAgreement() {
    return Row(
      children: [
        Checkbox(
          value: _isAccepted,
          onChanged: (bool? value) {
            setState(() {
              _isAccepted = value!;
            });
          },
        ),
        Text('I agree to the '),
        GestureDetector(
          onTap: () {
            // Show the Terms and Conditions when clicked
            _showTermsAndConditions(context);
          },
          child: Text(
            'Terms and Conditions',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget lendAmountWidget() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: amountController,
        keyboardType: TextInputType.number,
        autocorrect: false,
        style: const TextStyle(
            fontFamily: 'WorkSansSemiBold',
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: const Icon(
            FontAwesomeIcons.dollarSign,
            color: Colors.black,
          ),
          hintText: "Lend Amount",
          hintStyle:
              const TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
        ),
        onSubmitted: (_) {
          ;
        },
        textInputAction: TextInputAction.go,
      ),
    );
  }

  void _showTermsAndConditions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Terms and Conditions',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 10),
                Text(termsAndConditionsText, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        );
      },
    );
  }

  void _proceed() {
    final P2PSetupModel model =
        ModalRoute.of(context)!.settings.arguments as P2PSetupModel;

    String amount = amountController.text.trim();

    double? amountDouble = double.tryParse(amount);
    if (amountDouble == null) {
      showErrorDialog(context, "Failed", "Please enter a valid amount");
      return;
    }

    if (_isAccepted) {
      createTransaction(context, amountDouble, model.userId);
      showSuccessDialog(context, "Success", "Proposal submitted successfully!");
    } else {
      showErrorDialog(context, "Failed",
          "You must accept the Terms and Conditions to proceed.");
      return;
    }
  }

  void showErrorDialog(BuildContext context, String title, String text) {
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

  void showSuccessDialog(BuildContext context, String title, String text) {
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
                  Navigator.popAndPushNamed(context, '/dashboard')
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
