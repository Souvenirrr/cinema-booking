import 'package:cgv_clone/models/AccountModel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ProfileState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ProfileInital extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final AccountModel account;

  ProfileLoaded({@required this.account});
}

class ProfileFailure extends ProfileState {
  final String msg;

  ProfileFailure({@required this.msg});
}

class LogoutLoading extends ProfileState {}

class LogoutLoaded extends ProfileState {}

class LogoutFailure extends ProfileState {
  final String msg;

  LogoutFailure({@required this.msg});
}
