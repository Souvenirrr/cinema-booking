import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:cgv_clone/models/ScheduleModel.dart';
import 'package:flutter/material.dart';

class PageSeatArgs {
  final Times time;
  final MovieDetailModel movieDetail;
  PageSeatArgs({@required this.time, @required this.movieDetail});
}
