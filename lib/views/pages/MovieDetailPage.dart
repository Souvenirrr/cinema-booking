import 'package:cgv_clone/blocs/MovieDetailBloc.dart';
import 'package:cgv_clone/events/MovieDetailEvent.dart';
import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:cgv_clone/models/PageMovieDetailArgs.dart';
import 'package:cgv_clone/states/MovieDetailState.dart';
import 'package:cgv_clone/views/Theme.dart';
import 'package:cgv_clone/views/frags/LoadingWidget.dart';
import 'package:cgv_clone/views/frags/MovieDetailDescriptionWidget.dart';
import 'package:cgv_clone/views/frags/MovieDetailHeaderWidget.dart';
import 'package:cgv_clone/views/frags/MovieDetailInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieDetailArgs pageMovieDetailArgs;
  MovieDetailBloc _movieDetailBloc;

  MovieDetailPage({@required this.pageMovieDetailArgs});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('MovieDetailPage');
    _movieDetailBloc = BlocProvider.of<MovieDetailBloc>(context);
    _movieDetailBloc
        .add(MovieDetailStarted(movieDetailArgs: pageMovieDetailArgs));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.backgroundColor,
      ),
      backgroundColor: AppTheme.backgroundColor,
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, movieDetailState) {
          if (movieDetailState is MovieDetailLoading) return LoadingWidget();
          if (movieDetailState is MovieDetailLoaded)
            return _layout(movieDetailState.movieDetail);
          return LoadingWidget();
        },
      ),
    );
  }

  Widget _layout(MovieDetailModel movieDetail) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(15),
        color: AppTheme.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MovieDetailHeaderWidget(
                movieDetail: movieDetail,
              ),
              SizedBox(
                height: 15,
              ),
              MovieDetailInfo(
                movieDetailData: movieDetail,
              ),
              SizedBox(
                height: 15,
              ),
              MovieDetailDescriptionWidget(
                movieDetailData: movieDetail,
              )
            ],
          ),
        ));
  }
}
