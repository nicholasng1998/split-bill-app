import 'package:flutter/material.dart';
import 'package:flutter_application/services/expenses_group_service.dart';
import 'package:flutter_application/services/p2p_setup_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../model/common_response_model.dart';
import '../../theme.dart';
import '../../widgets/snackbar.dart';

class MerchantApplicationScreen extends StatelessWidget {
  TextEditingController amountController = TextEditingController();

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
              'P2P Merchant Application',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 120.0),
          child: Center(
            child: Column(children: <Widget>[
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
                        height: 150.0,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       top: 20.0,
                              //       bottom: 20.0,
                              //       left: 25.0,
                              //       right: 25.0),
                              //   child: TextField(
                              //     controller: groupNameController,
                              //     keyboardType: TextInputType.text,
                              //     textCapitalization: TextCapitalization.words,
                              //     autocorrect: false,
                              //     style: const TextStyle(
                              //         fontFamily: 'WorkSansSemiBold',
                              //         fontSize: 16.0,
                              //         color: Colors.black),
                              //     decoration: const InputDecoration(
                              //       border: InputBorder.none,
                              //       icon: Icon(
                              //         FontAwesomeIcons.snowflake,
                              //         color: Colors.black,
                              //       ),
                              //       hintText: "Group Name",
                              //       hintStyle: TextStyle(
                              //           fontFamily: 'WorkSansSemiBold',
                              //           fontSize: 16.0),
                              //     ),
                              //     onSubmitted: (_) {},
                              //   ),
                              // ),
                              // Container(
                              //   width: 250.0,
                              //   height: 1.0,
                              //   color: Colors.grey[400],
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 20.0,
                                    left: 25.0,
                                    right: 25.0),
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
                                    hintStyle: const TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 16.0),
                                  ),
                                  onSubmitted: (_) {
                                    ;
                                  },
                                  textInputAction: TextInputAction.go,
                                ),
                              ),
                              Container(
                                width: 250.0,
                                height: 1.0,
                                color: Colors.grey[400],
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       top: 20.0,
                              //       bottom: 20.0,
                              //       left: 25.0,
                              //       right: 25.0),
                              //   child: GestureDetector(
                              //     onTap: () => _selectDueDate(context),
                              //     child: AbsorbPointer(
                              //       child: TextField(
                              //         controller: dueDateController,
                              //         autocorrect: false,
                              //         style: const TextStyle(
                              //             fontFamily: 'WorkSansSemiBold',
                              //             fontSize: 16.0,
                              //             color: Colors.black),
                              //         decoration: InputDecoration(
                              //           border: InputBorder.none,
                              //           icon: const Icon(
                              //             FontAwesomeIcons.calendar,
                              //             color: Colors.black,
                              //           ),
                              //           hintText: "Due Date",
                              //           hintStyle: const TextStyle(
                              //               fontFamily: 'WorkSansSemiBold',
                              //               fontSize: 16.0),
                              //         ),
                              //         onSubmitted: (_) {},
                              //         textInputAction: TextInputAction.go,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 125.0),
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
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          'APPLY NOW',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: 'WorkSansBold'),
                        ),
                      ),
                      onPressed: () => {_applyP2P(context)},
                    ),
                  )
                ],
              ),
            ]),
          )),
    );
  }

  void _applyP2P(BuildContext context) async {
    String amount = amountController.text.trim();

    double? amountInt = double.tryParse(amount);
    if (amountInt == null) {
      showErrorDialog(context, "Failed", "Please enter a valid amount");
      return;
    }

    CommonResponseModel? commonResponseModel =
        await applyP2P(context, amountInt);

    if (commonResponseModel != null) {
      amountController.clear();
      showSuccessDialog(context, "Success", "Apply P2P Successfully");
    } else {
      showErrorDialog(context, "Failed", "Apply P2P Failed!");
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
                  Navigator.popAndPushNamed(context, '/dashboard'),
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
