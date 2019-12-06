import 'package:cgv_clone/models/SeatModel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class WalletEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class WalletLoadStarted extends WalletEvent {}

class WalletChanged extends WalletEvent {
  double moneyWallet;
  WalletChanged({@required this.moneyWallet});

  @override
  // TODO: implement props
  List<Object> get props => [moneyWallet];
}