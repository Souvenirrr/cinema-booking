import 'package:cgv_clone/models/PageMovieDetailArgs.dart';
import 'package:cgv_clone/models/PageScheduleArgs.dart';
import 'package:cgv_clone/models/PageSeatArgs.dart';
import 'package:cgv_clone/views/pages/AccountPage.dart';
import 'package:cgv_clone/views/pages/HomePage.dart';
import 'package:cgv_clone/views/pages/MovieDetailPage.dart';
import 'package:cgv_clone/views/pages/SchedulePage.dart';
import 'package:cgv_clone/views/pages/SeatPage.dart';
import 'package:flutter/material.dart';

enum RouterPath {
  account,
  home,
  movieDetail,
  schedule,
  seat,
  qr,
}

class RounterNames {
  static const String account = '/account';
  static const String home = '/';
  static const String movieDetail = '/movieDetail';
  static const String schedule = '/schedule';
  static const String seat = '/seat';
  static const qr = '/qr';
}

class Routers {
  static final define = {
    RounterNames.account: (context) => AccountPage(),
    RounterNames.home: (context) => HomePage(),
    RounterNames.account: (context) => AccountPage(),
  };
}

class GenarateRouter {
  static settings(RouteSettings settings) {
    switch (settings.name) {
      case RounterNames.account:
        return MaterialPageRoute(builder: (context) => AccountPage());
      case RounterNames.home:
        return MaterialPageRoute(builder: (context) => HomePage());
      case RounterNames.movieDetail:
        if (settings.arguments is MovieDetailArgs)
          return MaterialPageRoute(
              builder: (context) => MovieDetailPage(
                    pageMovieDetailArgs: settings.arguments,
                  ));
        break;
      case RounterNames.schedule:
        if (settings.arguments is PageScheduleArgs) {
          return MaterialPageRoute(
            builder: (context) => SchedulePage(
              pageScheduleArgs: settings.arguments,
            ),
          );
        }
        break;
      case RounterNames.seat:
        if (settings.arguments is PageSeatArgs) {
          return MaterialPageRoute(
            builder: (context) => SeatPage(pageSeatArgs: settings.arguments,),
          );
        }
        break;
    }
  }
}
