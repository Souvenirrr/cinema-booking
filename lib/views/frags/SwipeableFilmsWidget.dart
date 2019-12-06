import 'package:cached_network_image/cached_network_image.dart';
import 'package:cgv_clone/blocs/MovieBLoc.dart';
import 'package:cgv_clone/blocs/TabBloc.dart';
import 'package:cgv_clone/events/MovieEvent.dart';
import 'package:cgv_clone/events/TabEvent.dart';
import 'package:cgv_clone/models/MovieModel.dart';
import 'package:cgv_clone/states/MovieState.dart';
import 'package:cgv_clone/states/TabState.dart';
import 'package:cgv_clone/string/AppString.dart';
import 'package:cgv_clone/string/TabType.dart';
import 'package:cgv_clone/views/Theme.dart';
import 'package:cgv_clone/views/frags/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class SwipeableFilmsWidget extends StatefulWidget {
  final TabType tabType;
  SwipeableFilmsWidget({@required this.tabType});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SwipeableFilmsWidgetState(tabType: this.tabType);
  }
}

class _SwipeableFilmsWidgetState extends State<SwipeableFilmsWidget>
    with AutomaticKeepAliveClientMixin<SwipeableFilmsWidget> {
  final TabType tabType;
  _SwipeableFilmsWidgetState({@required this.tabType});
  PageController _pageController;
  double _currentIndex = 0;
  final double _viewportFraction = 0.75;
  var firstopen = true;
  TabBloc _tabBloc;
  MovieModel _movies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabBloc = BlocProvider.of<TabBloc>(context);
    _tabBloc.add(TabStarted(tabType: tabType));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return BlocBuilder<TabBloc, TabState>(
      builder: (context, tabState) {
        if (tabState is TabLoaded) _movies = tabState.movies;
        return _movies == null ? LoadingWidget() : _layout(_movies);
      },
    );
  }

  Widget _layout(MovieModel movies) {
    if (firstopen) {
      _currentIndex = (movies.movies.length / 2).toInt().toDouble();
      _pageController = PageController(
          viewportFraction: _viewportFraction,
          initialPage: _currentIndex.toInt());
      firstopen = !firstopen;
    }
    return Column(
      children: <Widget>[Expanded(flex: 1, child: _pageView(movies))],
    );
  }

  Widget _pageView(MovieModel movies) {
    return NotificationListener(
        onNotification: (Notification notification) {
          if (notification is ScrollUpdateNotification) {
            //print(_pageController.page);
            setState(() {
              _currentIndex = _pageController.page;
            });
          }
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: movies.movies.length,
          itemBuilder: (context, index) {
            double scale = (_currentIndex - index).abs();
            scale = scale >= _viewportFraction ? scale : _viewportFraction;
            print(_currentIndex.toString() +
                ' - ' +
                index.toString() +
                ' = ' +
                scale.toString());
            return MovieItem(
              movie: movies.movies[index],
              scale: scale,
            );
          },
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class MovieItem extends StatelessWidget {
  Movies movie;
  double scale;
  MovieBLoc _movieBLoc;
  MovieItem({@required this.movie, this.scale});
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    _movieBLoc = MovieBLoc();
    this.context = context;
    return BlocProvider<MovieBLoc>(
      create: (context) => _movieBLoc,
      child: BlocBuilder<MovieBLoc, MovieState>(
        builder: (context, movieState) {
          return _itemPageView(scale, movie);
        },
      ),
    );
  }

  Widget _itemPageView(double scale, Movies movie) {
    return LayoutBuilder(
      builder: (context, constraint) {
        print('Height: ' + constraint.maxHeight.toString());
        return Align(
          alignment: FractionalOffset.center,
          child: Stack(
            children: <Widget>[
              _movieBackground(constraint, scale, movie),
              _filter(constraint, scale),
              _movieInfo(constraint, scale, movie),
            ],
          ),
        );
      },
    );
  }

  Widget _movieInfo(BoxConstraints constraint, double scale, Movies movie) {
    return Container(
      width: double.infinity,
      height: ((constraint.maxHeight / 100) * 65) / scale,
      margin: EdgeInsets.only(left: 15, right: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      movie.movieName,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          decoration: BoxDecoration(
                            color: AppTheme.onSurface,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            movie.movieCens,
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          movie.movieLenght + ', ',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        Text(
                          movie.movieRelease,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: RaisedButton(
                      onPressed: () {
                        _movieBLoc
                            .add(MoviePressed(movie: movie, context: context));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      color: Colors.orange,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          AppString.bookButtonValue,
                          style: TextStyle(
                              color: AppTheme.onSurface, fontSize: 20),
                        ),
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget _filter(BoxConstraints constraint, double scale) {
    return Container(
      width: double.infinity,
      height: ((constraint.maxHeight / 100) * 65) / scale,
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
            begin: Alignment(0, 0),
            end: Alignment(0, 0.9),
            colors: [Colors.black.withOpacity(0), Colors.black.withOpacity(1)]),
      ),
    );
  }

  Widget _movieBackground(
      BoxConstraints constraint, double scale, Movies movie) {
    return Container(
        width: double.infinity,
        height: ((constraint.maxHeight / 100) * 65) / scale,
        margin: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                  movie.moviePoster,
                ),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(10))));
  }
}
