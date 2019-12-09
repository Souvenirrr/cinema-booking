import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class LoginEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoginButtonPressed extends LoginEvent {
  final String username, password;
  final BuildContext context;

  LoginButtonPressed(
      {@required this.username,
      @required this.password,
      @required this.context});
}
