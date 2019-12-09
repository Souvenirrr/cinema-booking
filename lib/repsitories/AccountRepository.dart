import 'dart:convert';

import 'package:cgv_clone/models/AccountModel.dart';
import 'package:cgv_clone/models/LogoutModel.dart';
import 'package:cgv_clone/navigate/Endpoint.dart';
import 'package:dio/dio.dart';

class AccountRepository {
  Future<AccountModel> info() async {
    try {
      Response response = await Dio().get(Endpoint.account);
      if (response.statusCode == 200)
        return AccountModel.fromJson(json.decode(response.toString()));
      else
        return null;
    } catch (e) {
      return null;
    }
  }

  Future<AccountModel> login(String username, String password) async {
    var dio = Dio();
    var response = await dio.get(Endpoint
        .login /*, data: {'username': username, 'password': password}*/);
    if (response.statusCode == 200)
      return AccountModel.fromJson(json.decode(response.toString()));
    else
      return null;
  }

  Future<AccountModel> register(
      username, phone, cmt, email, sex, birthday, password, repassword) async {
    var dio = Dio();
    var response = await dio.get(
      Endpoint
          .register, /*data: {
      'username': username,
      'password': password,
      'repassword': repassword,
      'phone': phone,
      'cmt': cmt,
      'email': email,
      'sex': sex,
      'birthday': birthday
    }*/
    );
    if (response.statusCode == 200)
      return AccountModel.fromJson(json.decode(response.toString()));
    else
      return null;
  }

  Future<LogoutModel> logout() async {
    var dio = Dio();
    var response = await dio.get(Endpoint.logout);
    if (response.statusCode == 200)
      return LogoutModel.fromJson(json.decode(response.toString()));
    else
      return null;
  }
}
