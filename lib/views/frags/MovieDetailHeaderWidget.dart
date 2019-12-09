import 'package:cached_network_image/cached_network_image.dart';
import 'package:cgv_clone/blocs/MovieDetailBloc.dart';
import 'package:cgv_clone/events/MovieDetailEvent.dart';
import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:cgv_clone/navigate/Endpoint.dart';
import 'package:cgv_clone/states/MovieDetailState.dart';
import 'package:cgv_clone/string/AppString.dart';
import 'package:cgv_clone/string/Youtube.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import '../Theme.dart';

class MovieDetailHeaderWidget extends StatelessWidget {
  final MovieDetailModel movieDetail;
  MovieDetailBloc _movieDetailBloc;

  MovieDetailHeaderWidget({this.movieDetail});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _movieDetailBloc = BlocProvider.of<MovieDetailBloc>(context);

    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, movieBLoc) {
        return _layout(context);
      },
    );
  }

  Container _layout(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _movieThumb(),
            SizedBox(
              height: 15,
            ),
            _movieInfo(context),
          ],
        ));
  }

  Row _movieInfo(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movieDetail.data.movieName,
                  style: TextStyle(
                      color: AppTheme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: AppTheme.onSurface,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    movieDetail.data.movieCens,
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ),
              ],
            )),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: RaisedButton(
              onPressed: () {
                print(movieDetail.data.movieName);
                _movieDetailBloc.add(MovieDetailButtonPressed(
                    context: context, movieDetail: movieDetail));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              color: Colors.orange,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppString.bookButtonValue,
                  style: TextStyle(color: AppTheme.onSurface, fontSize: 20),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Stack _movieThumb() {
    return Stack(
      children: <Widget>[
        Container(
          height: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: CachedNetworkImageProvider(
                      Endpoint.ytb_img_thumb(movieDetail.data.movieTrailer)))),
        ),
        Container(
          height: 200,
          decoration:
              BoxDecoration(color: AppTheme.surfaceColor.withOpacity(0.4)),
        ),
        Container(
          height: 200,
          child: Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                _playVideo(movieDetail.data.movieTrailer);
              },
              child: Icon(
                Icons.play_circle_filled,
                size: 70,
                color: AppTheme.onSurface,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _playVideo(String videoID) {
    return FlutterYoutube.playYoutubeVideoById(
        apiKey: Youtube.apiKey,
        videoId: videoID,
        autoPlay: false,
        fullScreen: true);
  }
}
