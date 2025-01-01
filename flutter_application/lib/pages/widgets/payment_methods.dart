import 'package:flutter/material.dart';
import 'package:flutter_application/services/friends_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/common_response_model.dart';
import '../../theme.dart';
import '../../widgets/snackbar.dart';

class ViewPaymentMethodScreen extends StatelessWidget {
  final List<String> availablePaymentMethods = ['Touch N Go', 'Cards'];

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
                'View Payment Method',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.only(top: 23.0),
            child: Center(
                child: Column(children: <Widget>[
              Text(
                "Currently Linked",
                style: const TextStyle(
                    fontFamily: "WorkSansSemiBold",
                    fontSize: 16.0,
                    color: Colors.black),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                width: 300.0,
                height: 200.0,
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
                        child: Text(
                          "Empty",
                          style: const TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                        )),
                  ])),
                ),
              ),
              Text(
                "Add Methods",
                style: const TextStyle(
                    fontFamily: "WorkSansSemiBold",
                    fontSize: 16.0,
                    color: Colors.black),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                width: 300.0,
                height: 200.0,
                child: Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                    ...availablePaymentMethods.map((method) {
                      return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 15.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      Colors.white, // Button background color
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Rounded corners
                                  border: Border.all(
                                    color: Colors.blue, // Border color
                                    width: 2.0, // Border width
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // Shadow position
                                    ),
                                  ]),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 20.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${method}",
                                  style: const TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0,
                                      color: Colors.black),
                                ),
                              )));
                    })
                  ])),
                ),
              ),
            ]))));
  }
}
