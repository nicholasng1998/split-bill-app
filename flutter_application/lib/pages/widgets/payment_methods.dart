import 'package:flutter/material.dart';
import 'package:flutter_application/services/friends_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/common_response_model.dart';
import '../../theme.dart';
import '../../widgets/snackbar.dart';

class ViewPaymentMethodScreen extends StatefulWidget {
  @override
  ViewPaymentMethodScreenState createState() => ViewPaymentMethodScreenState();
}

class ViewPaymentMethodScreenState extends State<ViewPaymentMethodScreen> {
  bool _isOnlineBankingOn = false;
  bool _isEwalletOn = false;

  @override
  Widget build(BuildContext context) {
    void _goToTouchNGo(BuildContext context) {
      print('Going to Touch N Go!');
      Navigator.pushNamed(
        context,
        '/touchNGoScreen',
      );
    }

    void _goToCards(BuildContext context) {
      print('Going to Cards!');
      Navigator.pushNamed(
        context,
        '/addCardScreen',
      );
    }

    // final List<Map<String, dynamic>> availablePaymentMethods = [
    //   {
    //     "text": "Touch N Go",
    //     "function": _goToTouchNGo,
    //   },
    //   {
    //     "text": "Cards",
    //     "function": _goToCards,
    //   },
    // ];

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
                    onlineBankingSwitch(),
                    eWalletSwitch()
                  ])),
                ),
              ),
            ]))));
  }

  void _toggleSwitch(bool value) {
    setState(() {
      _isOnlineBankingOn = value;
    });
  }

  Widget onlineBankingSwitch() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      child: Row(
        children: [
          Text(
            _isOnlineBankingOn ? 'Online Banking ON' : 'Online Banking OFF',
            style: TextStyle(fontSize: 20),
          ),
          Spacer(),
          Switch(
            value: _isOnlineBankingOn,
            onChanged: _toggleSwitch,
          ),
        ],
      ),
    );
  }

  Widget eWalletSwitch() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      child: Row(
        children: [
          Text(
            _isOnlineBankingOn ? 'E-Wallet ON' : 'E-Wallet OFF',
            style: TextStyle(fontSize: 20),
          ),
          Spacer(),
          Switch(
            value: _isOnlineBankingOn,
            onChanged: _toggleSwitch,
          ),
        ],
      ),
    );
  }
}
