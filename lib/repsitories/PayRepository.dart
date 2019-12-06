import 'dart:convert';

import 'package:cgv_clone/models/PaymentModel.dart';
import 'package:cgv_clone/navigate/Endpoint.dart';
import 'package:dio/dio.dart';

class PayRepository {
  Future<PaymentModel> pay(
      String scheduleID, double point, List<String> seatIDs) async {
    Response response =
        await Dio().get(Endpoint.payment(scheduleID, seatIDs, point));
    return PaymentModel.fromJson(json.decode(response.toString()));
  }
}
