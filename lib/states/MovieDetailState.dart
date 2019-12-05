import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MovieDetailState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class MovieDetailInital extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailModel movieDetail;
  MovieDetailLoaded({@required this.movieDetail});
}

class MovieDetailLoadFailure extends MovieDetailState {
  final String msg;
  MovieDetailLoadFailure({@required this.msg});
}
