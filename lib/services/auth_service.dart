import 'dart:convert';

import 'package:uts_pengembangan_aplikasi/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl =
      'https://pengembanganaplikasiweb-6a4b7af0e118.herokuapp.com/api';

  Future<UserModel> register(
      {String? name, String? email, String? password}) async {
    var url = '$baseUrl/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    print(response.body);

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data);
      // user.token = 'Bearer ' + data['token'];

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({String? email, String? password}) async {
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data);

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }
}
