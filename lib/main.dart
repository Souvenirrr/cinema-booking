import 'package:bloc/bloc.dart';
import 'package:cgv_clone/blocs/CalendarBloc.dart';
import 'package:cgv_clone/blocs/CartBloc.dart';
import 'package:cgv_clone/blocs/HomeBloc.dart';
import 'package:cgv_clone/blocs/MovieBLoc.dart';
import 'package:cgv_clone/blocs/MovieDetailBloc.dart';
import 'package:cgv_clone/blocs/ScheduleBLoc.dart';
import 'package:cgv_clone/blocs/SeatBLoc.dart';
import 'package:cgv_clone/blocs/SlideBloc.dart';
import 'package:cgv_clone/blocs/TabBloc.dart';
import 'package:cgv_clone/blocs/WalletBLoc.dart';
import 'package:cgv_clone/navigate/GenarateRouter.dart';
import 'package:cgv_clone/repsitories/AccountRepository.dart';
import 'package:cgv_clone/repsitories/MovieDetailRepository.dart';
import 'package:cgv_clone/repsitories/MovieRepository.dart';
import 'package:cgv_clone/repsitories/ScheduleRepository.dart';
import 'package:cgv_clone/repsitories/SeatRepository.dart';
import 'package:cgv_clone/repsitories/SlideRepository.dart';
import 'package:cgv_clone/views/Theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final MovieDetailRepository _movieDetailRepository = MovieDetailRepository();
final SlideRepository _slideRepository = SlideRepository();
final MovieRepository _tabRepository = MovieRepository();
final ScheduleRepository _scheduleRepository = ScheduleRepository();
final AccountRepository _accountRepository = AccountRepository();
final SeatRepository _seatRepository = SeatRepository();

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  return runApp(MultiBlocProvider(
    providers: [
      BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
      ),
      BlocProvider<MovieBLoc>(
        create: (context) => MovieBLoc(),
      ),
      BlocProvider<MovieDetailBloc>(
        create: (context) =>
            MovieDetailBloc(movieDetailRepository: _movieDetailRepository),
      ),
      BlocProvider<ScheduleBloc>(
        create: (context) =>
            ScheduleBloc(scheduleRepository: _scheduleRepository),
      ),
      BlocProvider<SlideBloc>(
        create: (context) => SlideBloc(slideRepository: _slideRepository),
      ),
      BlocProvider<TabBloc>(
        create: (context) => TabBloc(tabRepository: _tabRepository),
      ),
      BlocProvider<CalendarBloc>(
        create: (context) => CalendarBloc(),
      ),
      BlocProvider<SeatBloc>(
        create: (context) => SeatBloc(seatRepository: _seatRepository),
      ),
      BlocProvider<WalletBloc>(
        create: (context) => WalletBloc(accountRepository: _accountRepository),
      ),
      BlocProvider<CartBloc>(
        create: (context) => CartBloc(),
      ),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'CLone CGV',
      onGenerateRoute: (settings) {
        return GenarateRouter.settings(settings);
      },
      routes: Routers.define,
      theme: ThemeData(accentColor: AppTheme.surfaceColor),
    );
  }
}
