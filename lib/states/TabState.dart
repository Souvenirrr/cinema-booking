import 'package:cgv_clone/models/MovieModel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class TabState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class TabInital extends TabState {}

class TabLoading extends TabState {}

class TabLoaded extends TabState {
  final MovieModel movies;
  TabLoaded({@required this.movies});

  @override
  // TODO: implement props
  List<Object> get props => [movies];
}

class TabLoadFailure extends TabState {
  final String msg;
  TabLoadFailure({@required this.msg});
}

class Navigate extends TabState {
  final Movies movie;
  Navigate({@required this.movie});
}
