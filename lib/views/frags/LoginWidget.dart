import 'package:cgv_clone/string/AppString.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Theme.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginWidgetState();
  }
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController _usernameCtl = TextEditingController();
  TextEditingController _passwordCtl = TextEditingController();
  FocusNode _usernameFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: MediaQuery.of(context).padding,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 5),
                      decoration: BoxDecoration(
                          color: AppTheme.surfaceColor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Wrap(
                        children: <Widget>[
                          TextField(
                            controller: _usernameCtl,
                            focusNode: _usernameFocus,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocus);
                            },
                            style: TextStyle(color: AppTheme.onSurface),
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppString.hintUsername,
                              icon: Icon(
                                Icons.account_circle,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          TextField(
                            controller: _passwordCtl,
                            focusNode: _passwordFocus,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) {},
                            style: TextStyle(color: AppTheme.onSurface),
                            maxLines: 1,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppString.hintPassword,
                              icon: Icon(
                                Icons.lock,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(right: 20),
                      alignment: FractionalOffset.centerRight,
                      child: Wrap(
                        children: <Widget>[
                          Text(
                            AppString.hintForgotPassword,
                            style: TextStyle(
                                color: AppTheme.onSurface,
                                fontSize: 10,
                                fontWeight: FontWeight.w200),
                          ),
                        ],
                      )),
                  RaisedButton(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            AppString.loginStringValue,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Icon(
                            Icons.navigate_next,
                            size: 12,
                          ),
                        )
                      ],
                    ),
                    shape: CircleBorder(),
                    onPressed: () {},
                    color: AppTheme.surfaceColor,
                    textColor: AppTheme.onBackground,
                    padding: EdgeInsets.all(25),
                    splashColor: AppTheme.surfaceColor,
                    elevation: 1,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
