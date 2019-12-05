import 'package:cgv_clone/models/SlideModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SlideState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SlideInital extends SlideState {}

class SlideLoading extends SlideState {}

class SlideLoaded extends SlideState {
  final SlideModel slides;
  SlideLoaded({@required this.slides});

  @override
  // TODO: implement props
  List<Object> get props => [slides];
}

class SlideLoadFailure extends SlideState {
  final String msg;
  SlideLoadFailure({@required this.msg});
}
