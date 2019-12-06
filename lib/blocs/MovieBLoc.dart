import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/MovieEvent.dart';
import 'package:cgv_clone/models/PageMovieDetailArgs.dart';
import 'package:cgv_clone/navigate/GenarateRouter.dart';
import 'package:cgv_clone/states/MovieState.dart';
import 'package:flutter/material.dart';

class MovieBLoc extends Bloc<MovieEvent, MovieState> {
  @override
  // TODO: implement initialState
  MovieState get initialState => MovieInital();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    // TODO: implement mapEventToState
    if (event is MoviePressed) {
      Navigator.of(event.context).pushNamed(RouterNames.movieDetail,
          arguments: MovieDetailArgs(movie: event.movie));
    }
  }
}
