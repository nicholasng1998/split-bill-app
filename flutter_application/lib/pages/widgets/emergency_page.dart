import 'package:flutter/material.dart';
import 'package:flutter_application/services/emergency_service.dart';
import 'package:flutter_application/utils/user_state.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application/apis.dart';

class EmergencyScreen extends StatefulWidget {
  final String username;
  EmergencyScreen({required this.username});

  @override
  _EmergencyScreen createState() => _EmergencyScreen();
}

class _EmergencyScreen extends State<EmergencyScreen> {
  bool _isButtonClicked = false;
  void _handleButtonClick() {
    setState(() {
      _isButtonClicked = !_isButtonClicked;
    });
  }

  void onDataReceived(String data) {
    setState(() {
      _isButtonClicked = !_isButtonClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isButtonClicked
          ? EmergencyStatus(username: widget.username)
          : EmergencyRequest(
              username: widget.username, callback: onDataReceived),
      floatingActionButton: FloatingActionButton(
        heroTag: 'emergencyActionButton',
        onPressed: _handleButtonClick,
        child: Icon(Icons.add),
      ),
    );
  }
}

class EmergencyRequest extends StatefulWidget {
  final Function(String) callback;
  final String username;
  EmergencyRequest({required this.username, required this.callback});

  @override
  _EmergencyRequest createState() => _EmergencyRequest();
}

class _EmergencyRequest extends State<EmergencyRequest> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  void _create(BuildContext context) async {
    String title = titleController.text.trim();
    String message = messageController.text.trim();

    bool created = await create(widget.username, title, message);
    if (created) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Create Successfully'),
                content: Text('Please Check.'),
                actions: [
                  TextButton(
                    onPressed: () =>
                        {widget.callback('any'), Navigator.pop(context)},
                    child: Text('OK'),
                  ),
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Create Failed'),
                content: Text('Please Try Again.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Text('Emergency Request Form'),
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please input title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: messageController,
                decoration: InputDecoration(labelText: 'Emergency Description'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please input message';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  _create(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmergencyStatus extends StatefulWidget {
  final String username;
  EmergencyStatus({required this.username});

  @override
  _EmergencyStatus createState() => _EmergencyStatus();
}

class EmergencyResponseModel {
  final String title;
  final String message;
  final String status;

  EmergencyResponseModel({
    required this.title,
    required this.message,
    required this.status,
  });

  factory EmergencyResponseModel.fromJson(Map<String, dynamic> json) {
    return EmergencyResponseModel(
      title: json['title'],
      message: json['message'],
      status: json['status'],
    );
  }
}

class _EmergencyStatus extends State<EmergencyStatus> {
  @override
  void initState() {
    super.initState();
    fetchEmergencyStatusFromAPI(widget.username);
  }

  Future<void> fetchEmergencyStatusFromAPI(String username) async {
    final queryParameters = {'username': username};
    final uri = Uri.parse(EMERGENCY_REQUEST_READ_API)
        .replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> contentList = jsonData['content'];
      final List<EmergencyResponseModel> emergencyResponseModels =
          contentList.map((item) {
        return EmergencyResponseModel.fromJson(item);
      }).toList();

      setState(() {
        tableData = emergencyResponseModels;
      });
    }
  }

  List<EmergencyResponseModel> tableData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(scrollDirection: Axis.vertical, children: [
      SizedBox(height: 16.0),
      Center(
        child: Text('Emergency Request Status'),
      ),
      SizedBox(height: 16.0),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Title')),
            DataColumn(label: Text('Message')),
            DataColumn(label: Text('Status')),
          ],
          rows: tableData.map((data) {
            return DataRow(
              cells: [
                DataCell(Text(data.title ?? '')),
                DataCell(Text(data.message ?? '')),
                DataCell(Text(data.status ?? '')),
              ],
            );
          }).toList(),
        ),
      )
    ]));
  }
}
