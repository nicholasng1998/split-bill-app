import 'package:flutter/material.dart';
import 'package:flutter_application/pages/widgets/add-friends.dart';
import 'package:flutter_application/model/user_model.dart';
import 'package:flutter_application/services/user_service.dart';

import '../../theme.dart';
import '../../widgets/label-value-widget.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late Future<UserModel?> userModel;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nricController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userModel = get(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 23.0),
        child: FutureBuilder<UserModel?>(
          future: userModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final account = snapshot.data!;

              // Set initial values in the text controllers
              _emailController.text = account.username;
              _passwordController.text = account.password;
              _phoneController.text = account.mobileNo;
              _nricController.text = account.identityNo;

              return Padding(
                  padding: const EdgeInsets.only(top: 23.0),
                  child: Center(
                      child: Column(children: <Widget>[
                    Text(
                      "Account",
                      style: TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 25.0,
                          color: Colors.black),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      width: 400.0,
                      height: 420.0,
                      child: Card(
                        elevation: 2.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LabelValueWidget(
                                  label: 'Email:',
                                  value: account.username,
                                  isEditable: true,
                                  controller: _emailController,
                                ),
                                LabelValueWidget(
                                  label: 'Password:',
                                  value: account.password,
                                  isPassword: true,
                                  isEditable: true,
                                  controller: _passwordController,
                                ),
                                LabelValueWidget(
                                  label: 'Phone Number:',
                                  value: account.mobileNo,
                                  isEditable: true,
                                  controller: _phoneController,
                                ),
                                LabelValueWidget(
                                  label: 'NRIC No.:',
                                  value: account.identityNo,
                                  isEditable: true,
                                  controller: _nricController,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40.0),
                      decoration: BoxDecoration(
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
                          tileMode: TileMode.clamp,
                        ),
                      ),
                      child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: CustomTheme.loginGradientEnd,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: 'WorkSansBold',
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/addFriendsScreen');
                        },
                      ),
                    ),
                  ])));
            }
            return Center(child: Text('No data available'));
          },
        ));
  }
}
