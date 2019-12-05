import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/TabEvent.dart';
import 'package:cgv_clone/models/MovieModel.dart';
import 'package:cgv_clone/repsitories/MovieRepository.dart';
import 'package:cgv_clone/states/TabState.dart';
import 'package:meta/meta.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  final MovieRepository tabRepository;
  TabBloc({@required this.tabRepository});
  @override
  // TODO: implement initialState
  TabState get initialState => TabInital();

  @override
  Stream<TabState> mapEventToState(TabEvent event) async* {
    // TODO: implement mapEventToState
    if (event is TabStarted) {
      yield TabLoading();
      final MovieModel movies = await tabRepository.fetchByTab(event.tabType);
      yield TabLoaded(movies: movies);
    }
    if (event is TabExited) {}
  }
}
