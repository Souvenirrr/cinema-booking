import 'package:cgv_clone/blocs/LoginBloc.dart';
import 'package:cgv_clone/events/LoginEvent.dart';
import 'package:cgv_clone/repsitories/AccountRepository.dart';
import 'package:cgv_clone/repsitories/AuthenticateRepository.dart';
import 'package:cgv_clone/states/LoginState.dart';
import 'package:cgv_clone/string/AppString.dart';
import 'package:cgv_clone/views/frags/LoadingWidget.dart';
import 'package:cgv_clone/views/frags/SnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Theme.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginWidgetState();
  }
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _usernameCtl = TextEditingController();
  final TextEditingController _passwordCtl = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final LoginBloc _loginBloc = LoginBloc(
      accountRepository: AccountRepository(),
      authenticateRepository: AuthenticateRepository());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: MediaQuery.of(context).padding,
        child: BlocProvider<LoginBloc>(
          create: (context) => _loginBloc,
          child: BlocListener<LoginBloc, LoginState>(
              listener: (context, loginState) {
            print(loginState);
            if (loginState is LoginFailure)
              Scaffold.of(context).showSnackBar(snackBar(loginState.msg));
          }, child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, loginState) {
              return Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget>[
                            Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 0, bottom: 5),
                                decoration: BoxDecoration(
                                    color: AppTheme.surfaceColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
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
                                      style:
                                          TextStyle(color: AppTheme.onSurface),
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: AppString.hintUsername,
                                        icon: Icon(
                                          Icons.account_circle,
                                          color: Colors.white.withOpacity(0.9),
                                        ),
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.3),
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    TextField(
                                      controller: _passwordCtl,
                                      focusNode: _passwordFocus,
                                      textInputAction: TextInputAction.done,
                                      onSubmitted: (_) {},
                                      style:
                                          TextStyle(color: AppTheme.onSurface),
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
                                            color:
                                                Colors.white.withOpacity(0.3),
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
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
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
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              onPressed: () {
                                _loginBloc.add(LoginButtonPressed(
                                    username: _usernameCtl.text,
                                    password: _passwordCtl.text, context: context));
                              },
                              color: AppTheme.surfaceColor,
                              textColor: AppTheme.onBackground,
                              padding: EdgeInsets.all(5),
                              splashColor: AppTheme.surfaceColor,
                              elevation: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  (_loginBloc.state is LoginLoading)
                      ? LoadingWidget()
                      : Container(),
                ],
              );
            },
          )),
        ));
  }
}
