import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AuthenticationState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class AuthenticateInital extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class AuthenticateLoading extends AuthenticationState {}

class AuthenticateFailure extends AuthenticationState {
  final String msg;

  AuthenticateFailure({@required this.msg});
}
