import 'package:cgv_clone/views/frags/LoginWidget.dart';
import 'package:cgv_clone/views/frags/RegisterWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Theme.dart';

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AccountPageState();
  }
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  List<Widget> _tabLayouts = [LoginWidget(), RegisterWidget()];
  List<Tab> _tabTitles = [
    Tab(
      text: 'Đăng nhập',
    ),
    Tab(
      text: 'Đăng ký',
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(vsync: this, length: _tabLayouts.length);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: TabBar(
            onTap: (_) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            controller: _tabController,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: AppTheme.onSurface)),
            tabs: _tabTitles),
      ),
      body: Container(
          padding: MediaQuery.of(context).padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: TabBarView(
                    controller: _tabController,
                    children: _tabLayouts,
                    physics: NeverScrollableScrollPhysics(),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('Hoặc',
                                  style: TextStyle(
                                      color: AppTheme.onSurface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/google.png',
                                scale: 1,
                              ),
                              SizedBox.fromSize(
                                size: Size(15, 0),
                              ),
                              Image.asset(
                                'assets/facebook.png',
                                scale: 1.4,
                              ),
                            ],
                          ),
                        ],
                      )))
            ],
          )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
