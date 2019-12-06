import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/ScheduleEvent.dart';
import 'package:cgv_clone/models/PageSeatArgs.dart';
import 'package:cgv_clone/models/ScheduleModel.dart';
import 'package:cgv_clone/navigate/GenarateRouter.dart';
import 'package:cgv_clone/repsitories/ScheduleRepository.dart';
import 'package:cgv_clone/states/ScheduleState.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleRepository scheduleRepository;
  ScheduleBloc({@required this.scheduleRepository});

  @override
  // TODO: implement initialState
  ScheduleState get initialState => ScheduleInital();

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ScheduleStarted) {
      yield ScheduleLoading();
      final ScheduleModel schedules = await scheduleRepository.fetchByMovie(
          event.passPageScheduleArgs.movieDetail.movieId, event.dateTime);
      yield ScheduleLoaded(schedules: schedules);
    }
    if (event is ScheduleSelected) {
      yield ScheduleLoading();
      final ScheduleModel schedules = await scheduleRepository.fetchByMovie(
          event.passPageScheduleArgs.movieDetail.movieId, event.dateTime);
      yield ScheduleLoaded(schedules: schedules);
    }
    if (event is SchedulePressed) {
      Navigator.of(event.context).pushNamed(RouterNames.seat,
          arguments:
              PageSeatArgs(time: event.time, movieDetail: event.movieDetail));
    }
  }
}
