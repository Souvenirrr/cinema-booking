import 'package:cgv_clone/models/SeatModel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PayState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PayInital extends PayState {}

class PayLoading extends PayState {}

class Payed extends PayState {
  final Map<String, Seats> selectedSeats;
  final double totalPrice;
  Payed({@required this.selectedSeats, @required this.totalPrice});

  @override
  // TODO: implement props
  List<Object> get props => [selectedSeats, totalPrice];
}

class PayFailure extends PayState {
  final String msg;
  PayFailure({@required this.msg});
}
