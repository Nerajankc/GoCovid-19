import 'dart:convert';

import 'package:http/http.dart' as http;

class GoCorona {
  Future<Map<String, dynamic>> fetchCoronaData(String country) async {
    try {
      print("[GoCorona][FetchCoronaData] called");
      var url = "https://corona.lmao.ninja/$country";
      var response = await http.get("$url");
      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        return responseMap;
      }
      else return jsonDecode(response.body);
    } catch (err) {
      throw err;
    }
  }
}
