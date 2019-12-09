import 'package:cgv_clone/blocs/ScheduleBLoc.dart';
import 'package:cgv_clone/events/ScheduleEvent.dart';
import 'package:cgv_clone/models/PageScheduleArgs.dart';
import 'package:cgv_clone/models/ScheduleModel.dart';
import 'package:cgv_clone/repsitories/ScheduleRepository.dart';
import 'package:cgv_clone/states/ScheduleState.dart';
import 'package:cgv_clone/views/Theme.dart';
import 'package:cgv_clone/views/calendar_week/CalendarWeek.dart';
import 'package:cgv_clone/views/frags/LoadingWidget.dart';
import 'package:cgv_clone/views/frags/ScheduleItemExpanded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class SchedulePage extends StatefulWidget {
  final PageScheduleArgs pageScheduleArgs;
  ScheduleBloc _scheduleBloc;
  SchedulePage({@required this.pageScheduleArgs});
  @override
  _SchedulePageState createState() => _SchedulePageState(
        pageScheduleArgs: this.pageScheduleArgs,
      );
}

class _SchedulePageState extends State<SchedulePage> {
  final PageScheduleArgs pageScheduleArgs;
  ScheduleBloc _scheduleBloc =
      ScheduleBloc(scheduleRepository: ScheduleRepository());
  _SchedulePageState({@required this.pageScheduleArgs});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scheduleBloc.add(ScheduleStarted(
        passPageScheduleArgs: pageScheduleArgs, dateTime: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('SchedulePage');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.backgroundColor,
          elevation: 0,
          title: Text(pageScheduleArgs.movieDetail.data.movieName),
        ),
        backgroundColor: AppTheme.backgroundColor,
        body: BlocProvider<ScheduleBloc>(
          create: (context) => _scheduleBloc,
          child: _layout(context),
        ));
  }

  Container _layout(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _calendar(context),
          Expanded(
            flex: 1,
            child: SizedBox.expand(
              child: BlocBuilder<ScheduleBloc, ScheduleState>(
                builder: (context, scheduleState) {
                  if (scheduleState is ScheduleLoaded)
                    return _places(scheduleState.schedules);

                  return LoadingWidget();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _calendar(BuildContext context) {
    return CalendarWeek(
      buildContext: context,
      minDate: DateTime.now(),
      maxDate: DateTime.now().add(
        Duration(days: 14),
      ),
      selectedDate: DateTime.now(),
      todayButtonColor: AppTheme.surfaceColor,
      selectedDayButtonColor: Colors.blue,
      weekDaysLabelTextStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
      weekDaysTextStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
      weekDayButtonColor: AppTheme.backgroundColor,
      backgroundColor: AppTheme.backgroundColor,
      onTap: (DateTime datetime) {
        print(datetime);
        _scheduleBloc.add(ScheduleSelected(
            passPageScheduleArgs: pageScheduleArgs, dateTime: datetime));
      },
    );
  }

  Widget _places(ScheduleModel schedules) {
    return Container(
        color: AppTheme.backgroundColor,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: schedules.addresses.length,
          itemBuilder: (context, index) {
            return ScheduleItemExpanded(
              address: schedules.addresses[index].addressName,
              format: schedules.addresses[index].formats,
              movieDetail: pageScheduleArgs.movieDetail,
            );
          },
        ));
  }
}
