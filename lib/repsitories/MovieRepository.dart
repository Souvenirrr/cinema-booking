import 'dart:convert';

import 'package:cgv_clone/models/MovieModel.dart';
import 'package:cgv_clone/navigate/Endpoint.dart';
import 'package:cgv_clone/string/TabType.dart';
import 'package:dio/dio.dart';

class MovieRepository {
  Future<MovieModel> fetchByTab(TabType tabType) async {
    String url;
    if (tabType == TabType.showing) url = Endpoint.movies_list_showing;
    if (tabType == TabType.coming) url = Endpoint.movies_list_coming;
    if (tabType == TabType.special) url = Endpoint.movies_list_special;
    final Response response = await Dio().get(url);
    if (response.statusCode == 200)
      return MovieModel.fromJson(json.decode(response.toString()));
    else
      return null;
  }
}
