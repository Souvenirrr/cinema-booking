import 'dart:convert';

import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:cgv_clone/navigate/Endpoint.dart';
import 'package:dio/dio.dart';

class MovieDetailRepository {
  Future<MovieDetailModel> fetchByMovie(String movieID) async {
    try {
      final Response response = await Dio().get(Endpoint.movie_detail(movieID));
      if (response.statusCode == 200)
        return MovieDetailModel.fromJson(json.decode(response.toString()));
      else
        return null;
    } catch (e) {
      return null;
    }
  }
}
