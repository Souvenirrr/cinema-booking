import 'dart:convert';

import 'package:cgv_clone/business/remote/Endpoint.dart';
import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:dio/dio.dart';

class FetchMovieDetail {
  Future<MovieDetailModel> fetchByMovie(String movieID) async {
    final Response response = await Dio().get(Endpoint.movie_detail(movieID));
    return MovieDetailModel.fromJson(json.decode(response.toString()));
  }
}

