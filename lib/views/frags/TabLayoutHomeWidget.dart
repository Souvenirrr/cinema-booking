import 'package:cgv_clone/string/AppString.dart';
import 'package:cgv_clone/string/TabType.dart';
import 'package:cgv_clone/views/Theme.dart';
import 'package:flutter/material.dart';
import 'SwipeableFilmsWidget.dart';

class TabLayoutHomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabLayoutHomeWidgetState();
  }
}

class _TabLayoutHomeWidgetState extends State<TabLayoutHomeWidget> {
  final List<Widget> _tabs = [
    SwipeableFilmsWidget(tabType: TabType.showing),
    SwipeableFilmsWidget(tabType: TabType.coming),
    //SwipeableFilmsWidget(tabType: TabType.special)
  ];
  List<Tab> _tabTitles = [
    Tab(text: AppString.showing),
    Tab(text: AppString.comming),
    //Tab(text: AppString.special)
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return DefaultTabController(
        length: _tabs.length,
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              TabBar(
                  indicatorColor: AppTheme.onSurface,
                  isScrollable: false,
                  tabs: _tabTitles.map((v) => v).toList()),
              Expanded(
                flex: 1,
                child: TabBarView(children: _tabs.map((v) => v).toList()),
              )
            ],
          ),
        ));
  }
}
