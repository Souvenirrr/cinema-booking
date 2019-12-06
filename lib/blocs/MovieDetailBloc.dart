import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/MovieDetailEvent.dart';
import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:cgv_clone/models/PageScheduleArgs.dart';
import 'package:cgv_clone/navigate/GenarateRouter.dart';
import 'package:cgv_clone/repsitories/MovieDetailRepository.dart';
import 'package:cgv_clone/states/MovieDetailState.dart';
import 'package:flutter/material.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieDetailRepository movieDetailRepository;
  MovieDetailBloc({@required this.movieDetailRepository});

  @override
  // TODO: implement initialState
  MovieDetailState get initialState => MovieDetailInital();

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    // TODO: implement mapEventToState
    if (event is MovieDetailStarted) {
      yield MovieDetailLoading();
      final MovieDetailModel movieDetail = await movieDetailRepository
          .fetchByMovie(event.movieDetailArgs.movie.movieId);
      yield MovieDetailLoaded(movieDetail: movieDetail);
    }
    if (event is MovieDetailButtonPressed) {
      print(event);
      Navigator.of(event.context).pushNamed(RouterNames.schedule,
          arguments: PageScheduleArgs(movieDetail: event.movieDetail));
    }
    if (event is MovieDetailExited) {}
  }
}
