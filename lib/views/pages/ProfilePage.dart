import 'package:cgv_clone/blocs/ProfileBloc.dart';
import 'package:cgv_clone/events/ProfileEvent.dart';
import 'package:cgv_clone/models/AccountModel.dart';
import 'package:cgv_clone/repsitories/AccountRepository.dart';
import 'package:cgv_clone/repsitories/AuthenticateRepository.dart';
import 'package:cgv_clone/states/ProfileState.dart';
import 'package:cgv_clone/string/AppString.dart';
import 'package:cgv_clone/views/Theme.dart';
import 'package:cgv_clone/views/frags/LoadingWidget.dart';
import 'package:cgv_clone/views/frags/SnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc _profileBloc = ProfileBloc(
      accountRepository: AccountRepository(),
      authenticateRepository: AuthenticateRepository());
  AccountModel _account;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileBloc.add(ProfileStarted());
  }

  @override
  Widget build(BuildContext context) {
    print('ProfileScreen');
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(AppString.userInfo),
          backgroundColor: AppTheme.backgroundColor,
        ),
        body: BlocProvider<ProfileBloc>(
            create: (context) => _profileBloc,
            child: BlocListener<ProfileBloc, ProfileState>(
              listener: (context, profileState) {
                if (profileState is LogoutFailure)
                  Scaffold.of(context).showSnackBar(snackBar(profileState.msg));
              },
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, profileState) {
                  if (profileState is ProfileLoaded)
                    _account = profileState.account;
                  if (_account != null && profileState is LogoutLoading)
                    return Stack(
                      children: <Widget>[_layout(_account), LoadingWidget()],
                    );
                  if (_account != null) return _layout(_account);
                  return _layout(null);
                },
              ),
            )));
  }

  Widget _layout(AccountModel account) {
    return ListView(
      children: <Widget>[
        _header(
            account == null ? '' : account.info.username,
            account == null ? '' : account.info.point.toString(),
            account == null ? '' : account.info.money),
        _info(
            account == null ? '' : account.info.phone,
            account == null ? '' : account.info.cmt,
            account == null ? '' : account.info.email,
            account == null ? '' : account.info.sex,
            account == null ? '' : account.info.birthday,
            account == null ? '' : account.info.toString(),
            account == null ? '' : account.info.valueOf1Point.toString(),
            account == null ? '' : account.info.money),
        _logout()
      ],
    );
  }

  Widget _header(String username, String point, String money) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.account_circle,
            color: AppTheme.onSurface,
            size: 50,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  username,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      point + ' point',
                      style: TextStyle(color: AppTheme.onSurface),
                    ),
                    Text(
                      ' | ',
                      style: TextStyle(color: AppTheme.onSurface),
                    ),
                    Text(
                        money != ''
                            ? AppString.formatCurrency
                                    .format(double.parse(money)) +
                                ' ' +
                                AppString.vnd
                            : '',
                        style: TextStyle(color: AppTheme.onSurface))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _info(String phone, String cmt, String email, String sex,
      String birthday, String point, String valueOf1Point, String money) {
    return Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: <Widget>[
            _infoItem('SDT', phone),
            SizedBox(height: 5),
            _infoItem('CMT', cmt),
            SizedBox(height: 5),
            _infoItem('Email', email),
            SizedBox(height: 5),
            _infoItem('Sex',
                sex != '' ? sex[0].toUpperCase() + sex.substring(1) : ''),
            SizedBox(height: 5),
            _infoItem('Birthday', birthday),
          ],
        ));
  }

  Widget _infoItem(String label, String value) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            label + ': ',
            style: TextStyle(
                color: AppTheme.onSurface, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          flex: 2,
          child: Text(
            value,
            style: TextStyle(color: AppTheme.onSurface),
          ),
        )
      ],
    );
  }

  Widget _logout() {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Center(
        child: FlatButton(
          color: AppTheme.surfaceColor,
          onPressed: () {
            _profileBloc.add(LogoutButtonPressed(context: context));
          },
          child: Text(
            AppString.logout,
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
