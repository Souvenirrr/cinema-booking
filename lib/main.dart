import 'package:bloc/bloc.dart';
import 'package:cgv_clone/navigate/GenarateRouter.dart';
import 'package:cgv_clone/views/Theme.dart';
import 'package:cgv_clone/views/pages/HomePage.dart';
import 'package:flutter/material.dart';

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
  return runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Cinema booking',
      onGenerateRoute: (settings) {
        return GenerateRouter.settings(settings);
      },
      routes: {
        RouterNames.home: (context) => HomePage()
      },
      theme: ThemeData(accentColor: AppTheme.surfaceColor),
    );
  }
}
