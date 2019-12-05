import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/SeatEvent.dart';
import 'package:cgv_clone/models/SeatModel.dart';
import 'package:cgv_clone/repsitories/SeatRepository.dart';
import 'package:cgv_clone/states/SeatState.dart';
import 'package:meta/meta.dart';

class SeatBloc extends Bloc<SeatEvent, SeatState> {
  SeatRepository seatRepository;
  SeatBloc({@required this.seatRepository});
  @override
  // TODO: implement initialState
  SeatState get initialState => SeatInital();

  @override
  Stream<SeatState> mapEventToState(SeatEvent event) async* {
    // TODO: implement mapEventToState
    if (event is SeatLoadStarted) {
      print('SeatLoadStarted');
      yield SeatLoading();
      final SeatModel seats =
          await seatRepository.fetchBySchedule(event.scheduleID);
      yield SeatsLoaded(seats: seats);
    }
    if (event is SeatPressed) {
      yield SeatSelected(
          selectedSeats: event.selectedSeats);
    }
  }
}
