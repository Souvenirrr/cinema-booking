import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/HomeEvent.dart';
import 'package:cgv_clone/states/HomeState.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  // TODO: implement initialState
  HomeState get initialState => HomeInital();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // TODO: implement mapEventToState
    if(event is HomeStarted) {
      yield HomeLoading();
    }
    if(event is HomeExited){

    }
  }

}