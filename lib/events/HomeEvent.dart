import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class HomeEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class HomeStarted extends HomeEvent {}

class HomeExited extends HomeEvent {}

class ProfileButtonPressed extends HomeEvent {
  final BuildContext context;

  ProfileButtonPressed({@required this.context});
}
