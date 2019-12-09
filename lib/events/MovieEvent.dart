import 'package:cgv_clone/models/MovieModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class MovieEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class MoviePressed extends MovieEvent {
  BuildContext context;
  final Data movie;
  MoviePressed({@required this.context, @required this.movie});

  @override
  String toString() => 'Pressed on movie';
  @override
  // TODO: implement props
  List<Object> get props => [movie, context];
}
