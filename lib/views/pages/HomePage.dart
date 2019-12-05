import 'package:cgv_clone/blocs/HomeBloc.dart';
import 'package:cgv_clone/events/HomeEvent.dart';
import 'package:cgv_clone/states/HomeState.dart';
import 'package:cgv_clone/views/Theme.dart';
import 'package:cgv_clone/views/frags/LoadingWidget.dart';
import 'package:cgv_clone/views/frags/SlideHomePageWidget.dart';
import 'package:cgv_clone/views/frags/TabLayoutHomeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  HomeBloc _homeBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(HomeStarted());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('HomePage');
    return Scaffold(
      backgroundColor: AppTheme.surfaceColor,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, homeState) {
          if (homeState is HomeLoading)
            return Column(
              children: <Widget>[
                Expanded(flex: 2, child: SlideHomePageWidget()),
                Expanded(flex: 6, child: TabLayoutHomeWidget())
              ],
            );
          return LoadingWidget();
        },
      ),
    );
  }
}
