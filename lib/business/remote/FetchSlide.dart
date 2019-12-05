import 'dart:convert';

import 'package:cgv_clone/business/remote/Endpoint.dart';
import 'package:cgv_clone/models/SlideModel.dart';
import 'package:dio/dio.dart';

class FetchSlide {
  Future<SlideModel> fetch() async {
    final Response response = await Dio().get(Endpoint.slides);
    return SlideModel.fromJson(json.decode(response.toString()));
  }
}
