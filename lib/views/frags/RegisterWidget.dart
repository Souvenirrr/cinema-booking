import 'package:cgv_clone/string/AppString.dart';
import 'package:cgv_clone/views/Theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ResgisterWidgetState();
  }
}

class _ResgisterWidgetState extends State<RegisterWidget> {
  TextEditingController _usernameCtl = TextEditingController();
  TextEditingController _passwordCtl = TextEditingController();
  TextEditingController _reTypePaswordCtl = TextEditingController();
  TextEditingController _passportNumberCtl = TextEditingController();
  TextEditingController _birthDayCtl = TextEditingController();
  FocusNode _usernameFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _reTypePasswordFocus = FocusNode();
  FocusNode _passportNumberFocus = FocusNode();
  FocusNode _birthDayFocus = FocusNode();

  Future<DateTime> showDialog(BuildContext context) async {
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
                          left: 15, right: 15, top: 15, bottom: 15),
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
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_reTypePasswordFocus);
                            },
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
                          TextField(
                            controller: _reTypePaswordCtl,
                            focusNode: _reTypePasswordFocus,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: AppTheme.onSurface),
                            maxLines: 1,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppString.hintForgotPassword,
                              icon: Icon(
                                Icons.lock,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
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
                              style: TextStyle(color: AppTheme.onSurface),
                              maxLines: 1,
                              enabled: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppString.hintDate,
                                icon: Icon(
                                  Icons.date_range,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.3),
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
                            style: TextStyle(color: AppTheme.onSurface),
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '',
                              icon: Icon(
                                Icons.confirmation_number,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
                                  fontWeight: FontWeight.w300),
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
                                fontSize: 10, fontWeight: FontWeight.w300),
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
