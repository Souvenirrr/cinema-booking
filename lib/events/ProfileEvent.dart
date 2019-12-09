import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProfileEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ProfileStarted extends ProfileEvent {}

class LogoutButtonPressed extends ProfileEvent {
  final BuildContext context;

  LogoutButtonPressed({@required this.context});
}
