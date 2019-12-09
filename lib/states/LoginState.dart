import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class LoginState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String msg;

  LoginFailure({@required this.msg});
}
