import 'dart:convert';

import 'package:flutter/services.dart';

class JsonUtils {
  static Future<List<dynamic>> readJson(String jsonPath) async {
    final String response = await rootBundle.loadString(jsonPath);
    return jsonDecode(response);
  }
}