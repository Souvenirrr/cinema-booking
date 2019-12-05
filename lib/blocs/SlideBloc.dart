import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/SlideEvent.dart';
import 'package:cgv_clone/models/SlideModel.dart';
import 'package:cgv_clone/repsitories/SlideRepository.dart';
import 'package:cgv_clone/states/SlideState.dart';
import 'package:flutter/material.dart';

class SlideBloc extends Bloc<SlideEvent, SlideState> {
  final SlideRepository slideRepository;
  SlideBloc({@required this.slideRepository});
  @override
  // TODO: implement initialState
  SlideState get initialState => SlideInital();

  @override
  Stream<SlideState> mapEventToState(SlideEvent event) async* {
    // TODO: implement mapEventToState
    if (event is SlideStarted) {
      yield SlideLoading();
      final SlideModel slides = await slideRepository.fetch();
      yield SlideLoaded(slides: slides);
    }
    if (event is SlideExited) {}
  }
}
