import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/MovieDetailEvent.dart';
import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:cgv_clone/models/PageScheduleArgs.dart';
import 'package:cgv_clone/navigate/GenarateRouter.dart';
import 'package:cgv_clone/repsitories/AuthenticateRepository.dart';
import 'package:cgv_clone/repsitories/MovieDetailRepository.dart';
import 'package:cgv_clone/states/MovieDetailState.dart';
import 'package:flutter/material.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieDetailRepository movieDetailRepository;
  final AuthenticateRepository authenticateRepository;

  MovieDetailBloc(
      {@required this.movieDetailRepository,
      @required this.authenticateRepository});

  @override
  // TODO: implement initialState
  MovieDetailState get initialState => MovieDetailInital();

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    // TODO: implement mapEventToState
    if (event is MovieDetailStarted) {
      yield MovieDetailLoading();
      final MovieDetailModel movieDetail = await movieDetailRepository
          .fetchByMovie(event.movieDetailArgs.movie.movieId.toString());
      if (movieDetail != null)
        yield MovieDetailLoaded(movieDetail: movieDetail);
      else
        yield MovieDetailLoadFailure(msg: 'Error');
    }
    if (event is MovieDetailButtonPressed) {
      print(await authenticateRepository.readToken());
      //await authenticateRepository.deleteToken();
      if (await authenticateRepository.readToken() != false)
        Navigator.of(event.context).pushNamed(RouterNames.schedule,
            arguments: PageScheduleArgs(movieDetail: event.movieDetail));
      else
        Navigator.of(event.context).pushNamed(RouterNames.account);
    }
    if (event is MovieDetailExited) {}
  }
}
