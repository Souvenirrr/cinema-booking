import 'dart:convert';

import 'package:cgv_clone/models/SeatModel.dart';
import 'package:cgv_clone/navigate/Endpoint.dart';
import 'package:dio/dio.dart';

class SeatRepository {
   Future<SeatModel> fetchBySchedule(String scheduleID) async{
    Response response = await Dio().get(Endpoint.seats_state(scheduleID));
    return SeatModel.fromJson(json.decode(response.toString()));
  }
}