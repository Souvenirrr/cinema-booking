import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/RegisterEvent.dart';
import 'package:cgv_clone/models/AccountModel.dart';
import 'package:cgv_clone/repsitories/AccountRepository.dart';
import 'package:cgv_clone/repsitories/AuthenticateRepository.dart';
import 'package:cgv_clone/states/RegisterState.dart';
import 'package:cgv_clone/string/AppString.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  AccountRepository accountRepository;
  AuthenticateRepository authenticateRepository;

  RegisterBloc(
      {@required this.accountRepository,
      @required this.authenticateRepository});

  @override
  // TODO: implement initialState
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    // TODO: implement mapEventToState
    if (event is RegisterButtonPress) {
      yield RegisterLoading();
      final AccountModel accountModel = await accountRepository.register(
          event.username,
          event.phone,
          event.cmt,
          event.email,
          event.sex,
          event.birthday,
          event.password,
          event.repassword);
      if (accountModel != null) {
        if (event.username.trim().isNotEmpty &&
            event.phone.trim().isNotEmpty &&
            event.cmt.trim().isNotEmpty &&
            event.email.trim().isNotEmpty &&
            event.sex.trim().isNotEmpty &&
            event.birthday.trim().isNotEmpty &&
            event.password.trim().isNotEmpty &&
            event.repassword.trim().isNotEmpty) {
          if (event.password == event.repassword) {
            if (accountModel.status == 'ok') {
              if (await authenticateRepository.saveToken(accountModel.token)) {
                //yield RegisterSuccess();
                Navigator.of(event.context).pop();
              } else
                yield RegisterFailure(msg: AppString.saveTokenError);
            } else
              yield RegisterFailure(msg: accountModel.msg);
          } else
            yield RegisterFailure(msg: AppString.passwordIsNotMatch);
        } else
          yield RegisterFailure(msg: AppString.pleaseFitForm);
      } else
        yield RegisterFailure(msg: AppString.connectError);
    }
  }
}
