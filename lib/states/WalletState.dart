import 'package:cgv_clone/models/AccountModel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class WalletState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class WalletInital extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final AccountModel wallet;
  WalletLoaded({@required this.wallet});
}

class WalletFailure extends WalletState {
  final String msg;
  WalletFailure({@required this.msg});
}