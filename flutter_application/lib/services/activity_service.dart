import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/model/activity_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../apis.dart';
import '../provider/auth_token_provider.dart';

/**
 * Read Activity Function
 */
Future<List<ActivityModel>?> readActivities(BuildContext context) async {
  final String url = ACTIVITY_READ;
  final String? authToken =
      Provider.of<AuthTokenProvider>(context, listen: false).authToken;

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

      List<ActivityModel> activityModels =
          responseData.map((model) => ActivityModel.fromJson(model)).toList();

      print(activityModels);
      return activityModels;
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
