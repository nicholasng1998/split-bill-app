import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application/apis.dart';

Future<bool> create(String username, String title, String message) async {
  var url = Uri.parse(EMERGENCY_REQUEST_CREATE_API);

  print('title: ' + title);
  print('message: ' + message);

  Map<String, dynamic> data = {
    'username': username,
    'title': title,
    'message': message,
  };

  String jsonBody = json.encode(data);

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  http.Response response = await http.post(
    url,
    headers: headers,
    body: jsonBody,
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}


