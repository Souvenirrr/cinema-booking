import 'dart:convert';

import 'package:cgv_clone/models/SeatModel.dart';
import 'package:cgv_clone/navigate/Endpoint.dart';
import 'package:dio/dio.dart';

class SeatRepository {
  Future<SeatModel> fetchBySchedule(String scheduleID) async {
    try {
      Response response = await Dio().get(Endpoint.seats_state(scheduleID));
      if (response.statusCode == 200)
        return SeatModel.fromJson(json.decode(response.toString()));
      else
        return null;
    } catch (e) {
      return null;
    }
  }
}
