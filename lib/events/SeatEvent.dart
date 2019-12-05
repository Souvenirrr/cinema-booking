import 'package:cgv_clone/models/SeatModel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SeatEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SeatLoadStarted extends SeatEvent {
  final String scheduleID;
  SeatLoadStarted({@required this.scheduleID});
}

class SeatPressed extends SeatEvent {
  final Map<String, Seats> selectedSeats;
  SeatPressed({@required this.selectedSeats});

  @override
  // TODO: implement props
  List<Object> get props => [selectedSeats];
}
