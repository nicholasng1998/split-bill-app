import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/model/common_response_model.dart';
import 'package:flutter_application/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/apis.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/provider/auth_token_provider.dart';

/**
 * Create User Function
 */
Future<CommonResponseModel?> create(
    String identityNo,
    String mobileNo,
    String username,
    String password,
    String bankAccountNumber,
    String bankName,
    String name,) async {
  final String url = USER_CREATE;

  final Map<String, dynamic> requestData = {
    'username': username,
    'password': password,
    'identityNo': identityNo,
    'mobileNo': mobileNo,
    'bankAccountNumber': bankAccountNumber,
    'bankName': bankName,
    'name': name
  };

  try {
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      CommonResponseModel responseModel =
          CommonResponseModel.fromJson(responseData);

      print('Response: $responseModel');
      return responseModel;
    } else {
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    print('Finally');
  }
  return null;
}

/**
 * Get User Function
 */
Future<UserModel?> get(BuildContext context) async {
  final String url = USER_GET;

  final String? authToken =
      Provider.of<AuthTokenProvider>(context, listen: false).authToken;

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'auth-token': authToken ?? '',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      UserModel responseModel = UserModel.fromJson(responseData);

      print('Response: $responseModel');
      return responseModel;
    } else {
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    print('Finally');
  }
  return null;
}
