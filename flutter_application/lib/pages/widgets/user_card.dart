import 'package:flutter/material.dart';
import 'package:flutter_application/pages/widgets/dashboard_page.dart';

class UserCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String userType;
  final String unitNumber;

  const UserCard({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.userType,
    required this.unitNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: Container(
        width: 200,
        padding: EdgeInsets.only(top: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                firstName + " " + lastName,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                userType + " | " + unitNumber,
                style: TextStyle(
                  color: Colors.lightBlue.shade300,
                  fontSize: 20,
                ),
              ),
              // leading: Image.asset(
              //   iconImagePath,
              // ),
              trailing: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DashboardPage()));
                },
                child: Text('Change Units'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
