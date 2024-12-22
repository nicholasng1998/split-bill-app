import 'package:flutter/material.dart';
import 'package:flutter_application/pages/widgets/add-friends.dart';

import '../../theme.dart';

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 23.0),
        child: Center(
            child: Column(children: <Widget>[
          Text(
            "Activity",
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
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Abu paid you RM10.00 in Melaka Trip",
                              style: const TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                            ),
                          )),
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
          )
        ])));
  }
}
