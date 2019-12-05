import 'package:cgv_clone/models/PageSeatArgs.dart';
import 'package:cgv_clone/models/ScheduleModel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ScheduleState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ScheduleInital extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final ScheduleModel schedules;
  ScheduleLoaded({@required this.schedules});
}

class ScheduleLoadFailure extends ScheduleState {
  final String msg;
  ScheduleLoadFailure({@required this.msg});
}

class ScheduleNavigation extends ScheduleState {
  final PageSeatArgs pageSeatArgs;
  ScheduleNavigation({@required this.pageSeatArgs});
}
