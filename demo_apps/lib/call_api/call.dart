import 'dart:developer';

import 'package:dio/dio.dart';

import 'model.dart';

final client = Dio();
Future<PostModel> getDatas() async {
  final url = 'https://jsonplaceholder.typicode.com/posts';
  try {
    final response = await client.get(url);

    if (response.statusCode == 200) {
      List<PostModel> list = [];
      response.data.map((item) {
        PostModel postModel = PostModel.fromJson(item);
        list.add(postModel);
        print("Thanh: " + postModel.body);
        // print("Thanh1: " + list.length.toString());
        // print("Thanh: ")
      }).toList();
      return PostModel(body: "null", id: 0, title: "title", userId: 0);
    } else {
      print('${response.statusCode} : ${response.data.toString()}');

      return PostModel(body: "null", id: 0, title: "title", userId: 0);
    }
  } catch (error) {
    print(error);
    return PostModel(body: "null", id: 0, title: "title", userId: 0);
  }
}
