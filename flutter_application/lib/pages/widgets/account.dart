import 'package:flutter/material.dart';
import 'package:flutter_application/pages/widgets/add-friends.dart';

import '../../theme.dart';
import '../../widgets/label-value-widget.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 23.0),
        child: Center(
            child: Column(children: <Widget>[
          Text(
            "Account",
            style: const TextStyle(
                fontFamily: "WorkSansSemiBold",
                fontSize: 25.0,
                color: Colors.black),
          ),
          Flexible(
            child: Container(
                margin: const EdgeInsets.only(top: 20.0),
                width: 300.0,
                height: 350.0,
                child: Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LabelValueWidget(
                                label: 'Email:', value: 'test@gmail.com'),
                            LabelValueWidget(
                                label: 'Password:',
                                value: 'password123',
                                isPassword: true),
                            LabelValueWidget(
                                label: 'Phone Number:', value: 'xxx-xxxxxxx'),
                            LabelValueWidget(
                                label: 'NRIC No.:', value: '000000-00-0000'),
                          ],
                        ),
                      )
                    ]),
                  ),
                )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40.0),
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
                  'SAVE',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'WorkSansBold'),
                ),
              ),
              onPressed: () => {
                Navigator.pushNamed(
                  context,
                  '/addFriendsScreen',
                )
              },
            ),
          )
        ])));
  }
}
