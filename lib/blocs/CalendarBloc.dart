import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/CalendarEvent.dart';
import 'package:cgv_clone/states/CalendarState.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  @override
  // TODO: implement initialState
  CalendarState get initialState => CalendarInital();

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async* {
    // TODO: implement mapEventToState
    if (event is CalendarDayPressed) {
      yield CalendarDaySelected(dateTime: event.dateTime);
    }
    if (event is CalendarDayLongPressed) {
      yield CalendarDayHeid(dateTime: event.dateTime);
    }
  }
}
