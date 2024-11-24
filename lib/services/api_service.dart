import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lspokedex/utills/constants.dart' as Consts;

class ApiService {
    
  Future<dynamic> request({
    required String endpoint,
    required String method,
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    final url = Uri.parse('${Consts.apiUrl}$endpoint');

    http.Response response;
    try {
      
      headers ??= {};
      headers['Content-Type'] = 'application/json';
      headers['accept'] = 'application/json';

      switch(method) {
        case 'GET':
          response = await http.get(url, headers: headers);
          break;
        case 'POST':
          response = await http.post(url, headers: headers, body: '{"team_id" : "52c712ae-2f10-44e2-b734-e9659f5617f0"}');
          
          break;
        default:
          throw Exception('ERROR: unrecognized HTTP method');
      }
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('ERROR: unexpected response: ${response.statusCode}');
      }
    } catch (e){
      print('ERROR: $e');
      throw Exception('ERROR: HTTP request to API failed');
    }
  }
}