import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> findIp(String ip) async {
  String url = "https://apiip.net/api/check?accessKey=f02f6e80-e74b-498b-8756-f1795d78f4ac&ip=$ip";

  http.Response response = await http.get(Uri.parse(url));
  return jsonDecode(response.body);
}
