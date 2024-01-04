import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uts_pengembangan_aplikasi/models/user_model.dart';

class AuthService {
  String baseUrl = 'https://pengembanganaplikasiweb-6a4b7af0e118.herokuapp.com/api';

  Future<UserModel?> register({
    String? name,
    String? email,
    String? password,
  }) async {
    var url = Uri.parse('$baseUrl/register');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });

    try {
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        UserModel user = UserModel.fromJson(data);
        return user;
      } else {
        // Log error
        print('Failed to register: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      // Handle exception
      print('Exception occurred: $e');
      return null;
    }
  }

  Future<UserModel?> login({
    String? email,
    String? password,
  }) async {
    var url = Uri.parse('$baseUrl/login');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        UserModel user = UserModel.fromJson(data);
        return user;
      } else {
        // Log error
        print('Failed to login: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      // Handle exception
      print('Exception occurred: $e');
      return null;
    }
  }
}
