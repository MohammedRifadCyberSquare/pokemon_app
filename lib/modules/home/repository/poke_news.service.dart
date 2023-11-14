import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class PokeNewsService {
  Future<dynamic> fetchNews() async {
    try {
      String file = await rootBundle.loadString('assets/news.json');
      Map<String, dynamic> jsonData = json.decode(file);
      List<dynamic> newsData = jsonData['news'];
      print(newsData);
      return jsonData;
    } catch (e) {
      print(e);
    }
  }
}
