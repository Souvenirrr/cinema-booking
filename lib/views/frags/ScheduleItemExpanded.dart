import 'package:cgv_clone/blocs/ScheduleBLoc.dart';
import 'package:cgv_clone/events/ScheduleEvent.dart';
import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:cgv_clone/models/ScheduleModel.dart';
import 'package:cgv_clone/states/ScheduleState.dart';
import 'package:cgv_clone/views/Theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleItemExpanded extends StatefulWidget {
  final String address;
  final List<Formats> format;
  final MovieDetailModel movieDetail;
  ScheduleItemExpanded(
      {@required this.address,
      @required this.format,
      @required this.movieDetail});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScheduleItemExpandedState(
        address: this.address,
        moviesFormat: this.format,
        movieDetail: this.movieDetail);
  }
}

class ScheduleItemExpandedState extends State<ScheduleItemExpanded> {
  final String address;
  final List<Formats> moviesFormat;
  final MovieDetailModel movieDetail;
  ScheduleBloc _scheduleBloc;

  bool _isExpanded = false;

  ScheduleItemExpandedState(
      {@required this.address,
      @required this.moviesFormat,
      @required this.movieDetail});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scheduleBloc = BlocProvider.of<ScheduleBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, scheduleState) {
        return _layout();
      },
    );
  }

  Theme _layout() {
    return Theme(
      child: ExpansionTile(
          onExpansionChanged: (_) {
            setState(() {
              _isExpanded = _;
            });
          },
          trailing: Icon(
              _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: AppTheme.onSurface),
          title: ListTileTheme(
            contentPadding: EdgeInsets.zero,
            child: Text(
              address,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
          children: moviesFormat
              .map((format) => _movieFormatAndTime(format.format, format.times))
              .toList()),
      data: ThemeData(dividerColor: AppTheme.backgroundColor),
    );
  }

  Widget _movieFormatAndTime(String format, List<Times> times) {
    return Wrap(
      children: <Widget>[
        _movieFormat(format),
        _movieTimes(times),
      ],
    );
  }

  Container _movieTimes(List<Times> times) {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      alignment: Alignment.centerLeft,
      child: Wrap(
          children: times
              .map((time) => Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: InkWell(
                    onTap: () {
                      print(time.start);
                      _scheduleBloc.add(SchedulePressed(
                        context: context,
                        time: time,
                        movieDetail: movieDetail,
                      ));
                    },
                    child: Chip(
                      backgroundColor: Colors.blue,
                      label: Text(
                        time.start,
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.onBackground),
                      ),
                    ),
                  )))
              .toList()),
    );
  }

  Container _movieFormat(String format) {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      alignment: Alignment.centerLeft,
      child: Text(
        format,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
