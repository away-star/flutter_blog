import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeAPI {
  static const String baseUrl = 'http://localhost:9000';
  //static const String baseUrl = 'https://your-api-url.com';

  static Future<dynamic> getBaseData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/service-content/post/page?step=5'));
    if (response.statusCode == 200) {
      // 返回解析后的JSON数据
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      // 如果请求失败，抛出异常
      throw Exception('Failed to load data!');
    }
  }

  static Future<dynamic> getPostList(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    if (response.statusCode == 200) {
      // 返回解析后的JSON数据
      return json.decode(response.body);
    } else {
      // 如果请求失败，抛出异常
      throw Exception('Failed to load data!');
    }
  }
}
