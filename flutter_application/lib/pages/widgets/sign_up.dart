import 'package:flutter/material.dart';
import 'package:flutter_application/model/common_response_model.dart';
import 'package:flutter_application/services/user_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application/theme.dart';
import 'package:flutter_application/widgets/snackbar.dart';

const String EMAIL = "Email";
const String PASSWORD = "Password";
const String CONFIRM_PASSWORD = "Confirm Password";
const String NRIC_NO = "NRIC No.";
const String PHONE_NO = "Phone Number";

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final FocusNode focusNodeNricNo = FocusNode();
  final FocusNode focusNodePhoneNo = FocusNode();

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController =
      TextEditingController();
  TextEditingController signupPhoneNoController = TextEditingController();
  TextEditingController signupNricNoController = TextEditingController();
  TextEditingController bankAccountNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    focusNodeNricNo.dispose();
    focusNodePhoneNo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                    width: 300.0,
                    height: 360.0,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          emailWidget(),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          passwordWidget(),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          confirmPasswordWidget(),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          nricNoWidget(),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          phoneNumberWidget(),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          bankAccountNumberWidget(),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          bankNameWidget(),
                        ],
                      ),
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 340.0),
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
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'WorkSansBold'),
                    ),
                  ),
                  onPressed: () => {_toggleSignUpButton(context)},
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget emailWidget() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        focusNode: focusNodeEmail,
        controller: signupEmailController,
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.words,
        autocorrect: false,
        style: const TextStyle(
            fontFamily: 'WorkSansSemiBold',
            fontSize: 16.0,
            color: Colors.black),
        decoration: const InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            FontAwesomeIcons.envelope,
            color: Colors.black,
          ),
          hintText: EMAIL,
          hintStyle: TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
        ),
      ),
    );
  }

  Widget passwordWidget() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        focusNode: focusNodePassword,
        controller: signupPasswordController,
        obscureText: _obscureTextPassword,
        autocorrect: false,
        style: const TextStyle(
            fontFamily: 'WorkSansSemiBold',
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              FontAwesomeIcons.lock,
              color: Colors.black,
            ),
            hintText: PASSWORD,
            hintStyle:
                TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
            suffixIcon: GestureDetector(
              onTap: _toggleSignup,
              child: Icon(
                _obscureTextPassword
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
                size: 15.0,
                color: Colors.black,
              ),
            )),
        onSubmitted: (_) {
          focusNodePassword.requestFocus();
        },
      ),
    );
  }

  Widget confirmPasswordWidget() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        focusNode: focusNodeConfirmPassword,
        controller: signupConfirmPasswordController,
        obscureText: _obscureTextConfirmPassword,
        autocorrect: false,
        style: const TextStyle(
            fontFamily: 'WorkSansSemiBold',
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: const Icon(
            FontAwesomeIcons.lock,
            color: Colors.black,
          ),
          hintText: CONFIRM_PASSWORD,
          hintStyle:
              const TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
          suffixIcon: GestureDetector(
            onTap: _toggleSignupConfirm,
            child: Icon(
              _obscureTextConfirmPassword
                  ? FontAwesomeIcons.eye
                  : FontAwesomeIcons.eyeSlash,
              size: 15.0,
              color: Colors.black,
            ),
          ),
        ),
        onSubmitted: (_) {
          focusNodeConfirmPassword.requestFocus();
        },
      ),
    );
  }

  Widget nricNoWidget() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        focusNode: focusNodeNricNo,
        controller: signupNricNoController,
        keyboardType: TextInputType.text,
        autocorrect: false,
        style: const TextStyle(
            fontFamily: 'WorkSansSemiBold',
            fontSize: 16.0,
            color: Colors.black),
        decoration: const InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            FontAwesomeIcons.user,
            color: Colors.black,
          ),
          hintText: NRIC_NO,
          hintStyle: TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
        ),
        onSubmitted: (_) {
          focusNodePassword.requestFocus();
        },
      ),
    );
  }

  Widget phoneNumberWidget() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        focusNode: focusNodePhoneNo,
        controller: signupPhoneNoController,
        keyboardType: TextInputType.number,
        autocorrect: false,
        style: const TextStyle(
            fontFamily: 'WorkSansSemiBold',
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: const Icon(
            FontAwesomeIcons.phone,
            color: Colors.black,
          ),
          hintText: PHONE_NO,
          hintStyle:
              const TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
        ),
        onSubmitted: (_) {
          focusNodePhoneNo.requestFocus();
        },
        textInputAction: TextInputAction.go,
      ),
    );
  }

  Widget bankAccountNumberWidget() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: bankAccountNumberController,
        keyboardType: TextInputType.number,
        autocorrect: false,
        style: const TextStyle(
            fontFamily: 'WorkSansSemiBold',
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: const Icon(
            FontAwesomeIcons.piggyBank,
            color: Colors.black,
          ),
          hintText: "Bank Account Number",
          hintStyle:
              const TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
        ),
      ),
    );
  }

  Widget bankNameWidget() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: bankNameController,
        keyboardType: TextInputType.text,
        autocorrect: false,
        style: const TextStyle(
            fontFamily: 'WorkSansSemiBold',
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: const Icon(
            FontAwesomeIcons.buildingColumns,
            color: Colors.black,
          ),
          hintText: "Bank Name",
          hintStyle:
              const TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
        ),
      ),
    );
  }

  void _toggleSignUpButton(BuildContext context) async {
    String email = signupEmailController.text.trim();
    String password = signupPasswordController.text.trim();
    String confirmPassword = signupConfirmPasswordController.text.trim();
    String mobileNo = signupPhoneNoController.text.trim();
    String identityNo = signupNricNoController.text.trim();
    String bankAccountNumber = bankAccountNumberController.text.trim();
    String bankName = bankNameController.text.trim();

    if (password != confirmPassword) {
      showErrorDialog(context, "Failed", "Password not matched!");
      return;
    }

    CommonResponseModel? commonResponseModel = await create(
        identityNo, mobileNo, email, password, bankAccountNumber, bankName);

    if (commonResponseModel != null) {
      signupEmailController.clear();
      signupPasswordController.clear();
      signupConfirmPasswordController.clear();
      signupPhoneNoController.clear();
      signupNricNoController.clear();
      bankAccountNumberController.clear();
      bankNameController.clear();
      showSuccessDialog(context, "Success", "Sign Up Successfully!");
    } else {
      showErrorDialog(context, "Failed", "Sign up failed! Please try again.");
    }
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
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
