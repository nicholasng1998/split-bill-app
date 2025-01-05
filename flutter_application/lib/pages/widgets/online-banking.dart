import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme.dart';

class OnlineBankingScreen extends StatefulWidget {
  @override
  OnlineBankingScreenState createState() => OnlineBankingScreenState();
}

class OnlineBankingScreenState extends State<OnlineBankingScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              'Online Banking',
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
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                child: usernameTextField(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                child: passwordTextField(),
              ),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  bool isLogin() {
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (isLogin()) {
          showPaymentSuccessDialog(context, "Success", "Login Successful!");
        } else {
          showPaymentErrorDialog(
              context, "Failed", "Please enter username and password!");
        }
      },
      child: Text("Login",
          style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              fontSize: 16.0,
              color: Colors.white)),
    );
  }

  Widget passwordTextField() {
    return TextField(
      controller: passwordController,
      obscureText: true,
      keyboardType: TextInputType.text,
      style: const TextStyle(
          fontFamily: "WorkSansSemiBold", fontSize: 16.0, color: Colors.black),
      decoration: const InputDecoration(
        border: InputBorder.none,
        icon: Icon(
          FontAwesomeIcons.lock,
          color: Colors.black,
          size: 22.0,
        ),
        hintText: "Password",
        hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 17.0),
      ),
    );
  }

  Widget usernameTextField() {
    return TextField(
      controller: usernameController,
      keyboardType: TextInputType.text,
      style: const TextStyle(
          fontFamily: "WorkSansSemiBold", fontSize: 16.0, color: Colors.black),
      decoration: const InputDecoration(
        border: InputBorder.none,
        icon: Icon(
          FontAwesomeIcons.user,
          color: Colors.black,
          size: 22.0,
        ),
        hintText: "Username",
        hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 17.0),
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 23.0),
      child: Center(
        child: Text(
          "CIMB Bank",
          style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              fontSize: 25.0,
              color: Colors.black),
        ),
      ),
    );
  }

  void showPaymentSuccessDialog(
      BuildContext context, String title, String text) {
    List<dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
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
                  Navigator.pushNamed(
                      context, "/onlineBankingConfirmationScreen",
                      arguments: arguments),
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
