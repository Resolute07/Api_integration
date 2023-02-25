import 'dart:io';

import 'package:http/http.dart' as http;

class ApiClient {
  static const String _baseUrl = 'https://reqres.in/api/';

  static Future<http.Response> fetchData(String api) async {
    final response = await http.get(Uri.parse(_baseUrl + api));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw (exitCode);
    }
  }
}
