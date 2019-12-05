import 'package:cgv_clone/models/AccountModel.dart';
import 'package:cgv_clone/models/SeatModel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class WalletState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PayInital extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final AccountModel wallet;
  WalletLoaded({@required this.wallet});
}

class WalletFailure extends WalletState {
  final String msg;
  WalletFailure({@required this.msg});
}

class PayLoad extends WalletState {
  final Map<String, Seats> selectedSeats;
  final double point;
  PayLoad({@required this.selectedSeats, @required this.point});

  @override
  // TODO: implement props
  List<Object> get props => [selectedSeats, point];
}

class PayLoading extends WalletState {}

class Payed extends WalletState {
  final Map<String, Seats> selectedSeats;
  final double totalPrice;
  Payed({@required this.selectedSeats, @required this.totalPrice});

  @override
  // TODO: implement props
  List<Object> get props => [selectedSeats, totalPrice];
}

class PayFailure extends WalletState {
  final String msg;
  PayFailure({@required this.msg});
}
