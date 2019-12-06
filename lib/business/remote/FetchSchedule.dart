import 'dart:convert';

import 'package:cgv_clone/business/remote/Endpoint.dart';
import 'package:cgv_clone/models/ScheduleModel.dart';
import 'package:dio/dio.dart';

class FetchSchedule {
  Future<ScheduleModel> fetchByMovie(String movieID, DateTime dateTime) async {
    final Response response =
        await Dio().get(Endpoint.schedules_by_movie(movieID, dateTime));
    return ScheduleModel.fromJson(json.decode(response.toString()));
  }
}