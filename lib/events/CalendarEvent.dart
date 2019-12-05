import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CalendarEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CalendarDayPressed extends CalendarEvent {
  DateTime dateTime;
  CalendarDayPressed({@required this.dateTime});
}

class CalendarDayLongPressed extends CalendarEvent {
  DateTime dateTime;
  CalendarDayLongPressed({@required this.dateTime});
}
