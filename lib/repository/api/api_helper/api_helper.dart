import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app_with_riverpod/repository/api/api_config/app_config.dart';

class ApiHelper {
  static Future<String?> getData({required String endpoint}) async {
    final url = Uri.parse(AppConfig.baseUril + endpoint + AppConfig.apiKey);
    try {
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        return resp.body;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
