import 'package:flutter/material.dart';

final _hiddenDate = null;

class CalendarWeek extends StatefulWidget {
  // Parent build Context;
  final BuildContext buildContext;
  final DateTime minDate;
  final DateTime maxDate;
  final TextStyle weekDaysLabelTextStyle;
  final TextStyle weekDaysTextStyle;
  final Color todayButtonColor;
  final Color selectedDayButtonColor;
  final Color weekDayButtonColor;
  final void Function(DateTime) onTap;
  final Color backgroundColor;
  DateTime selectedDate = null;

  CalendarWeek({
    @required this.buildContext,
    @required this.maxDate,
    @required this.minDate,
    this.weekDaysLabelTextStyle = const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15),
    this.weekDaysTextStyle = const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
    this.todayButtonColor = Colors.pinkAccent,
    this.selectedDayButtonColor = Colors.blueAccent,
    this.weekDayButtonColor = Colors.transparent,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.selectedDate = null
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CalendarWeekState(
      buildContext: this.buildContext,
      minDate: this.minDate,
      maxDate: this.maxDate,
      weekDaysLabelTextStyle: this.weekDaysLabelTextStyle,
      weekDaysTextStyle: this.weekDaysTextStyle,
      toDayButtonColor: this.todayButtonColor,
      selectedDayButtonColor: this.selectedDayButtonColor,
      weekDayButtonColor: this.weekDayButtonColor,
      onTap: this.onTap,
      backgroundColor: this.backgroundColor,
      selectedDate: this.selectedDate
    );
  }
}

class _CalendarWeekState extends State<CalendarWeek> {
  final BuildContext buildContext;
  final DateTime minDate;
  final DateTime maxDate;
  final TextStyle weekDaysLabelTextStyle;
  final TextStyle weekDaysTextStyle;
  final Color toDayButtonColor;
  final Color selectedDayButtonColor;
  final Color weekDayButtonColor;
  final void Function(DateTime) onTap;
  final Color backgroundColor;

  DateTime selectedDate = null;
  DateTime _today = DateTime.now();

  _CalendarWeekState({
    @required this.buildContext,
    @required this.minDate,
    @required this.maxDate,
    this.weekDaysLabelTextStyle,
    this.weekDaysTextStyle,
    this.toDayButtonColor,
    this.selectedDayButtonColor,
    this.weekDayButtonColor,
    this.backgroundColor,
    this.onTap,
    this.selectedDate = null
  });
  double _screenWidth;
  double _screenHeight;
  Map<int, String> _weekDaysLabel = {
    1: 'T2',
    2: 'T3',
    3: 'T4',
    4: 'T5',
    5: 'T6',
    6: 'T7',
    7: 'CN'
  };
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _screenWidth = MediaQuery.of(buildContext).size.width;
    _screenHeight = MediaQuery.of(buildContext).size.height;
    final List<String> weekDayLabel7Days = List();
    final List<DateTime> weekDay7Days = List();
    final List<Widget> tabs = List();
    int countUntil7 = 0;
    //print(minDate);
    //print(maxDate);
    if (minDate.compareTo(maxDate) > 0)
      return Text(
          'minDate much before maxDate, please fix it before show the CalendarWeek');

    if (maxDate.difference(minDate).inDays > 360000) {
      return Text(
          'Over 1000 years, please fix it before show the CalendarWeek');
    }
    DateTime minDateCopy = minDate;
    while (minDateCopy.compareTo(maxDate) < 1) {
      if (countUntil7 < 7) {
        weekDayLabel7Days.add(_weekDaysLabel[minDateCopy.weekday]);
        weekDay7Days.add(minDateCopy);
        countUntil7++;
      } else {
        countUntil7 = 1;
        tabs.add(_week(weekDayLabel7Days, weekDay7Days));
        weekDayLabel7Days.clear();
        weekDay7Days.clear();
        weekDayLabel7Days.add(_weekDaysLabel[minDateCopy.weekday]);
        weekDay7Days.add(minDateCopy);
      }
      minDateCopy = minDateCopy.add(Duration(days: 1));
    }

    if (countUntil7 != 0) {
      tabs.add(_week(weekDayLabel7Days, weekDay7Days));
      weekDayLabel7Days.clear();
      weekDay7Days.clear();
    }

    return Container(
      color: backgroundColor,
      height: (_screenHeight / 100) * 12,
      width: double.infinity,
      child: PageView(
        controller: _pageController,
        children: tabs.map((value) => value).toList(),
      ),
    );
  }

  Widget _week(List<String> weekDaysLabel, List<DateTime> weekDays) {
    if (weekDaysLabel.length != weekDays.length)
      return Text(
          'Lenght of WeekDaysLabel is not same weekDays. Please fix it before show the CalendarWeek');

    for (int i = 0; i < 7; i++) {
      if (i > weekDaysLabel.length) {
        weekDaysLabel.add(_weekDaysLabel[i + 1]);
        weekDays.add(_hiddenDate);
      }
    }

    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          _labels(weekDaysLabel),
          _days(weekDays),
        ],
      ),
    );
    //return Text('Not available now');
  }

  Expanded _days(List<DateTime> weekDays) {
    return Expanded(
      flex: 1,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: weekDays
              .map((day) => Expanded(flex: 1, child: _itemDay(day)))
              .toList()),
    );
  }

  Expanded _labels(List<String> weekDaysLabel) {
    return Expanded(
      flex: 1,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: weekDaysLabel
              .map((label) => Expanded(flex: 1, child: _itemLabel(label)))
              .toList()),
    );
  }

  Widget _itemLabel(String label) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        label,
        style: weekDaysLabelTextStyle,
      ),
    );
  }

  Widget _itemDay(DateTime date) {
    return Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onLongPress: () {
            _onDayLongPress(date);
          },
          child: RaisedButton(
            elevation: 0,
            color: date != _hiddenDate &&
                    date.day == _today.day &&
                    date.month == _today.month &&
                    date.year == _today.year
                ? date != _hiddenDate &&
                        selectedDate != null &&
                        date.day == _today.day &&
                        date.month == _today.month &&
                        date.year == _today.year &&
                        date.day == selectedDate.day &&
                        date.month == selectedDate.month &&
                        date.year == selectedDate.year
                    ? selectedDayButtonColor
                    : toDayButtonColor
                : selectedDate != null &&
                        date != _hiddenDate &&
                        date.day == selectedDate.day &&
                        date.month == selectedDate.month &&
                        date.year == selectedDate.year
                    ? selectedDayButtonColor
                    : weekDayButtonColor,
            onPressed: () {
              _onDayPress(date);
            },
            shape: CircleBorder(),
            child: Text(
              date != _hiddenDate ? date.day.toString() : '',
              style: weekDaysTextStyle,
            ),
          ),
        ));
  }

  _onDayPress(DateTime date) {
    if (date != _hiddenDate) {
      setState(() {
        selectedDate = date;
      });
      onTap(selectedDate);
    }
  }

  _onDayLongPress(DateTime date) {
    if (date != _hiddenDate) {
      setState(() {
        selectedDate = date;
        onTap(selectedDate);
      });
    }
  }
}
