import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/LoginEvent.dart';
import 'package:cgv_clone/models/AccountModel.dart';
import 'package:cgv_clone/repsitories/AccountRepository.dart';
import 'package:cgv_clone/repsitories/AuthenticateRepository.dart';
import 'package:cgv_clone/states/LoginState.dart';
import 'package:cgv_clone/string/AppString.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AccountRepository accountRepository;
  AuthenticateRepository authenticateRepository;

  LoginBloc(
      {@required this.authenticateRepository,
      @required this.accountRepository});

  @override
  // TODO: implement initialState
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      final AccountModel accountModel =
          await accountRepository.login(event.username, event.password);
      if (accountModel != null) {
        if (event.username == 'minhduc' && event.password == '1234') {
          if (accountModel.status == 'ok') {
            if (await authenticateRepository.saveToken(accountModel.token)) {
              //yield LoginSuccess();
              Navigator.of(event.context).pop();
            } else
              yield LoginFailure(msg: AppString.loiluutoken);
          } else
            yield LoginFailure(msg: AppString.saitaikhoan);
        } else {
          await Future.delayed(Duration(seconds: 2));
          yield LoginFailure(msg: AppString.saitaikhoan);
        }
      } else
        yield LoginFailure(msg: AppString.loiconnect);
    }
  }
}
