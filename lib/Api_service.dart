import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:msaudit/user_model.dart';




class FetchTasklist {
  List<Tasklist> results = [];
  String urlList =
      'https://mstracker-api.197.253.69.230.sslip.io/api/tasklist';

  Future<List<Tasklist>> getTasklist({String? query}) async {
    try {
      var response = await http.get(Uri.parse(urlList));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        results = data.map((e) => Tasklist.fromJson(e)).toList();

        if (query != null && query.isNotEmpty) {
          results = results.where((element) =>
              element.task_id!.toLowerCase().contains(query.toLowerCase())).toList();
        }
      } else {
        print("fetch error: ${response.statusCode}");
      }
    } catch (e) {
      print('error: $e');
    }
    return results;
  }
}
