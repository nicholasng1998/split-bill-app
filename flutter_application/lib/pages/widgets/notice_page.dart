import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_application/utils/user_state.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application/apis.dart';

class NoticeResponseModel {
  final int id;
  final String title;
  final String content;
  final Bool isActive;

  NoticeResponseModel({
    required this.id,
    required this.title,
    required this.content,
    required this.isActive,
  });

  factory NoticeResponseModel.fromJson(Map<String, dynamic> json) {
    return NoticeResponseModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      isActive: json['isActive'],
    );
  }
}

class NoticeScreen extends StatelessWidget {
  Future<List<NoticeResponseModel>> fetchItems() async {
    final response = await http.get(Uri.parse(NOTICE_READ_API));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> contentList = jsonData['content'];

      final List<NoticeResponseModel> noticeResponseModels =
          contentList.map((item) {
        return NoticeResponseModel.fromJson(item);
      }).toList();
      return noticeResponseModels;
    } else {
      throw Exception('Failed to fetch items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("hello"),
    );
    // return Scaffold(
    //   body: FutureBuilder<List<NoticeResponseModel>>(
    //     future: fetchItems(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         final items = snapshot.data!;
    //         return ListView.builder(
    //           itemCount: items.length,
    //           itemBuilder: (context, index) {
    //             return GestureDetector(
    //               onTap: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) =>
    //                         ItemDetailsScreen(item: items[index]),
    //                   ),
    //                 );
    //               },
    //               child: Card(
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(16.0),
    //                   child: Text(items[index].title),
    //                 ),
    //               ),
    //             );
    //           },
    //         );
    //       } else if (snapshot.hasError) {
    //         return Center(
    //           child: Text('Error: ${snapshot.error}'),
    //         );
    //       } else {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     },
    //   ),
    // );
  }
}

class ItemDetailsScreen extends StatelessWidget {
  final NoticeResponseModel item;

  ItemDetailsScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Html(
        data: item.content,
      ),
    );
  }
}
