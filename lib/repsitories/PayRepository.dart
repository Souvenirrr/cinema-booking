import 'dart:convert';

import 'package:cgv_clone/models/PaymentModel.dart';
import 'package:cgv_clone/navigate/Endpoint.dart';
import 'package:dio/dio.dart';

class PayRepository {
  Future<PaymentModel> pay(
      String scheduleID, double point, List<String> seatIDs) async {
    try {
      Response response =
          await Dio().get(Endpoint.payment(scheduleID, seatIDs, point));
      if (response.statusCode == 200)
        return PaymentModel.fromJson(json.decode(response.toString()));
      else
        return null;
    } catch (e) {
      return null;
    }
  }
}
