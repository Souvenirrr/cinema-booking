import 'package:cgv_clone/blocs/RegisterBloc.dart';
import 'package:cgv_clone/events/RegisterEvent.dart';
import 'package:cgv_clone/repsitories/AccountRepository.dart';
import 'package:cgv_clone/repsitories/AuthenticateRepository.dart';
import 'package:cgv_clone/states/RegisterState.dart';
import 'package:cgv_clone/string/AppString.dart';
import 'package:cgv_clone/views/Theme.dart';
import 'package:cgv_clone/views/frags/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RegisterWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterWidgetState();
  }
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController _usernameCtl = TextEditingController();
  final TextEditingController _passwordCtl = TextEditingController();
  final TextEditingController _reTypePasswordCtl = TextEditingController();
  final TextEditingController _passportNumberCtl = TextEditingController();
  final TextEditingController _birthDayCtl = TextEditingController();
  final TextEditingController _phoneCtl = TextEditingController();
  final TextEditingController _emailCtl = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _reTypePasswordFocus = FocusNode();
  final FocusNode _passportNumberFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  var sex = AppString.male;
  final RegisterBloc _registerBloc = RegisterBloc(
      accountRepository: AccountRepository(),
      authenticateRepository: AuthenticateRepository());

  Future showDialog(BuildContext context) async {
    DateTime selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2090),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );

    DateFormat df = DateFormat('dd/MM/yyyy');
    _birthDayCtl.text = selectedDate == null ? '' : df.format(selectedDate);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<RegisterBloc>(
      create: (context) => _registerBloc,
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, registerState) {},
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, registerState) {
            return Stack(
              children: <Widget>[
                Container(
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
                                      left: 15, right: 15, top: 0, bottom: 15),
                                  decoration: BoxDecoration(
                                      color: AppTheme.surfaceColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
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
                                        style: TextStyle(
                                            color: AppTheme.onSurface),
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: AppString.hintUsername,
                                          icon: Icon(
                                            Icons.account_circle,
                                            color:
                                                Colors.white.withOpacity(0.9),
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
                                        textInputAction: TextInputAction.next,
                                        onSubmitted: (_) {
                                          FocusScope.of(context).requestFocus(
                                              _reTypePasswordFocus);
                                        },
                                        style: TextStyle(
                                            color: AppTheme.onSurface),
                                        maxLines: 1,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: AppString.hintPassword,
                                          icon: Icon(
                                            Icons.lock,
                                            color:
                                                Colors.white.withOpacity(0.9),
                                          ),
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      TextField(
                                        controller: _reTypePasswordCtl,
                                        focusNode: _reTypePasswordFocus,
                                        textInputAction: TextInputAction.done,
                                        onSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(_phoneFocus);
                                        },
                                        style: TextStyle(
                                            color: AppTheme.onSurface),
                                        maxLines: 1,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: AppString.rePassword,
                                          icon: Icon(
                                            Icons.lock,
                                            color:
                                                Colors.white.withOpacity(0.9),
                                          ),
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      TextField(
                                        controller: _phoneCtl,
                                        focusNode: _phoneFocus,
                                        textInputAction: TextInputAction.done,
                                        onSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(_emailFocus);
                                        },
                                        keyboardType: TextInputType.phone,
                                        style: TextStyle(
                                            color: AppTheme.onSurface),
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: AppString.phone,
                                          icon: Icon(
                                            Icons.phone,
                                            color:
                                                Colors.white.withOpacity(0.9),
                                          ),
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      TextField(
                                        controller: _emailCtl,
                                        focusNode: _emailFocus,
                                        textInputAction: TextInputAction.done,
                                        style: TextStyle(
                                            color: AppTheme.onSurface),
                                        maxLines: 1,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: AppString.email,
                                          icon: Icon(
                                            Icons.email,
                                            color:
                                                Colors.white.withOpacity(0.9),
                                          ),
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(context);
                                        },
                                        child: TextField(
                                          controller: _birthDayCtl,
                                          textInputAction: TextInputAction.next,
                                          style: TextStyle(
                                              color: AppTheme.onSurface),
                                          maxLines: 1,
                                          enabled: false,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: AppString.hintDate,
                                            icon: Icon(
                                              Icons.date_range,
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                            ),
                                            hintStyle: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ),
                                      TextField(
                                        controller: _passportNumberCtl,
                                        focusNode: _passportNumberFocus,
                                        textInputAction: TextInputAction.next,
                                        onSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(_passwordFocus);
                                        },
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                            color: AppTheme.onSurface),
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: AppString.cmt,
                                          icon: Icon(
                                            Icons.confirmation_number,
                                            color:
                                                Colors.white.withOpacity(0.9),
                                          ),
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      Theme(
                                        data: ThemeData(
                                            canvasColor:
                                                AppTheme.backgroundColor),
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: AppString.cmt,
                                            icon: Icon(
                                              Icons.face,
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                            ),
                                          ),
                                          items: <String>[
                                            AppString.male,
                                            AppString.female
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(
                                                value,
                                                style: TextStyle(
                                                    color: AppTheme.onSurface),
                                              ),
                                            );
                                          }).toList(),
                                          value: sex,
                                          onChanged: (_) {
                                            setState(() {
                                              sex = _;
                                            });
                                          },
                                        ),
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
                                        AppString.registerStringValue,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Icon(
                                        Icons.navigate_next,
                                        size: 10,
                                      ),
                                    )
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                onPressed: () {
                                  _registerBloc.add(RegisterButtonPress(
                                    phone: _phoneCtl.text,
                                    birthday: _birthDayCtl.text,
                                    repassword: _reTypePasswordCtl.text,
                                    password: _passwordCtl.text,
                                    username: _usernameCtl.text,
                                    sex: null,
                                    email: _emailCtl.text,
                                    cmt: _passportNumberCtl.text,
                                  ));
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
                    )),
                (_registerBloc.state is RegisterLoading)
                    ? LoadingWidget()
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}
