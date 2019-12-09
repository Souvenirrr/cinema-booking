import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/HomeEvent.dart';
import 'package:cgv_clone/navigate/GenarateRouter.dart';
import 'package:cgv_clone/repsitories/AuthenticateRepository.dart';
import 'package:cgv_clone/states/HomeState.dart';
import 'package:flutter/material.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticateRepository authenticateRepository;

  HomeBloc({@required this.authenticateRepository});

  @override
  // TODO: implement initialState
  HomeState get initialState => HomeInital();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // TODO: implement mapEventToState
    if (event is HomeStarted) {
      yield HomeLoading();
    }
    if (event is ProfileButtonPressed) {
      if (await authenticateRepository.readToken() != false)
        Navigator.of(event.context).pushNamed(RouterNames.profile);
      else
        Navigator.of(event.context).pushNamed(RouterNames.account);
    }
    if (event is HomeExited) {}
  }
}
