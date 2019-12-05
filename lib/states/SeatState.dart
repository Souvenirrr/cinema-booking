import 'package:cgv_clone/models/SeatModel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SeatState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SeatInital extends SeatState {}

class SeatSelected extends SeatState {
  final Map<String, Seats> selectedSeats;
  SeatSelected({@required this.selectedSeats});

  @override
  // TODO: implement props
  List<Object> get props => [selectedSeats];
}

class SeatLoading extends SeatState {}

class SeatsLoaded extends SeatState {
  final SeatModel seats;
  SeatsLoaded({@required this.seats});

  @override
  // TODO: implement props
  List<Object> get props => [seats];
}
