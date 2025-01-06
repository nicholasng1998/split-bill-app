import 'package:flutter/material.dart';
import 'package:flutter_application/model/activity_model.dart';
import 'package:intl/intl.dart';

import '../../services/activity_service.dart';
import '../../theme.dart';

class ActivityScreen extends StatefulWidget {
  @override
  ActivityState createState() => ActivityState();
}

class ActivityState extends State<ActivityScreen> {
  List<ActivityModel> activityModels = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var activityModels = await readActivities(context) ?? [];
    setState(() {
      this.activityModels = activityModels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Center(
        child: Column(
          children: <Widget>[
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
                width: 350.0,
                height: 600.0,
                child: Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ...activityModels.map(
                          (model) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
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
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 20.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: itemListText(model),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
          ],
        ),
      ),
    );
  }

  Widget itemListText(ActivityModel activityModel) {
    String formattedDate =
        DateFormat('yyyy-MM-dd h:mma').format(activityModel.createdDate);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${formattedDate}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Container(
              width: 250,
              child: Text(
                '${activityModel.action}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
