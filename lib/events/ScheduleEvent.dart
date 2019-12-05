import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:cgv_clone/models/PageScheduleArgs.dart';
import 'package:cgv_clone/models/PageSeatArgs.dart';
import 'package:cgv_clone/models/ScheduleModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ScheduleEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ScheduleStarted extends ScheduleEvent {
  final PageScheduleArgs passPageScheduleArgs;
  final DateTime dateTime;
  ScheduleStarted(
      {@required this.passPageScheduleArgs, @required this.dateTime});

  @override
  // TODO: implement props
  List<Object> get props => [passPageScheduleArgs];
}

class ScheduleSelected extends ScheduleEvent {
  final PageScheduleArgs passPageScheduleArgs;
  final DateTime dateTime;
  ScheduleSelected(
      {@required this.passPageScheduleArgs, @required this.dateTime});

  @override
  // TODO: implement props
  List<Object> get props => [passPageScheduleArgs];
}

class ScheduleExited extends ScheduleEvent {}

class SchedulePressed extends ScheduleEvent {
  final BuildContext context;
  final Times time;
  final MovieDetailModel movieDetail;
  SchedulePressed(
      {@required this.context,
      @required this.time,
      @required this.movieDetail});
}
