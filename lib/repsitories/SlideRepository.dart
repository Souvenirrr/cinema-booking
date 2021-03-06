import 'dart:convert';

import 'package:cgv_clone/models/SlideModel.dart';
import 'package:cgv_clone/navigate/Endpoint.dart';
import 'package:dio/dio.dart';

class SlideRepository {
  Future<SlideModel> fetch() async {
    try {
      final Response response = await Dio().get(Endpoint.slides);
      if (response.statusCode == 200)
        return SlideModel.fromJson(json.decode(response.toString()));
      else
        return null;
    } catch (e) {
      return null;
    }
  }
}
