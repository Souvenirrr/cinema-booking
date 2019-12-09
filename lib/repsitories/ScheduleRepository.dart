import 'dart:convert';

import 'package:cgv_clone/models/ScheduleModel.dart';
import 'package:cgv_clone/navigate/Endpoint.dart';
import 'package:dio/dio.dart';

class ScheduleRepository {
  Future<ScheduleModel> fetchByMovie(String movieID, DateTime dateTime) async {
    try {
      final Response response =
          await Dio().get(Endpoint.schedules_by_movie(movieID, dateTime));

      if (response.statusCode == 200)
        return ScheduleModel.fromJson(json.decode(response.toString()));
      else
        return null;
    } catch (e) {
      return null;
    }
  }
}
