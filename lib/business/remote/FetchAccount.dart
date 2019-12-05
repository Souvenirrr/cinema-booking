import 'dart:convert';

import 'package:cgv_clone/business/remote/Endpoint.dart';
import 'package:cgv_clone/models/AccountModel.dart';
import 'package:dio/dio.dart';

class FetchAccount {
  Future<AccountModel> fetch() async {
    Response response = await Dio().get(Endpoint.account);
    return AccountModel.fromJson(json.decode(response.toString()));
  }
}
