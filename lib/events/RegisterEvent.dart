import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class RegisterEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RegisterButtonPress extends RegisterEvent {
  final BuildContext context;
  final String username, phone, email, sex, birthday, password, repassword, cmt;

  RegisterButtonPress(
      {@required this.username,
      @required this.phone,
      @required this.cmt,
      @required this.email,
      @required this.sex,
      @required this.birthday,
      @required this.password,
      @required this.repassword,
      @required this.context});
}
