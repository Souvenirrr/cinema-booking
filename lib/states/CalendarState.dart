import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CalendarState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CalendarInital extends CalendarState {}

class CalendarDaySelected extends CalendarState {
  final DateTime dateTime;
  CalendarDaySelected({@required this.dateTime});
}

class CalendarDayHeid extends CalendarState {
  final DateTime dateTime;
  CalendarDayHeid({@required this.dateTime});
}
