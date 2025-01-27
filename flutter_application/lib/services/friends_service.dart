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
 * Add Friends Function
 */
Future<CommonResponseModel?> addFriend(
    BuildContext context, String email) async {
  final String url = FRIENDS_CREATE;
  final String? authToken =
      Provider.of<AuthTokenProvider>(context, listen: false).authToken;

  var params = {
    'email': email,
  };

  try {
    final response = await http.post(Uri.parse(url),
        headers: {
          'auth-token': authToken ?? '',
        },
        body: params);

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
 * Read Friends Function
 */
Future<List<UserModel>?> readFriends(BuildContext context) async {
  final String url = FRIENDS_READ;
  final String? authToken = Provider.of<AuthTokenProvider>(context).authToken;

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'auth-token': authToken ?? '',
    });

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        return null;
      }
      List<dynamic> responseData = json.decode(response.body);
      print('Response: $responseData');

      List<UserModel> userModels =
          responseData.map((user) => UserModel.fromJson(user)).toList();

      print(userModels);
      return userModels;
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
