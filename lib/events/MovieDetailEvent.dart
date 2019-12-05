import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:cgv_clone/models/PageMovieDetailArgs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class MovieDetailEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class MovieDetailStarted extends MovieDetailEvent {
  final MovieDetailArgs movieDetailArgs;
  MovieDetailStarted({@required this.movieDetailArgs});

  @override
  // TODO: implement props
  List<Object> get props => [this.movieDetailArgs];
}

class MovieDetailButtonPressed extends MovieDetailEvent {
  final MovieDetailModel movieDetail;
  final BuildContext context;
  MovieDetailButtonPressed({@required this.context, this.movieDetail});

  @override
  // TODO: implement props
  List<Object> get props => [context, movieDetail];

  @override
  String toString() => 'Pressed on movie detail';
}

class MovieDetailExited extends MovieDetailEvent {}
