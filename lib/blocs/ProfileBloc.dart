import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/ProfileEvent.dart';
import 'package:cgv_clone/models/AccountModel.dart';
import 'package:cgv_clone/models/LogoutModel.dart';
import 'package:cgv_clone/repsitories/AccountRepository.dart';
import 'package:cgv_clone/repsitories/AuthenticateRepository.dart';
import 'package:cgv_clone/states/ProfileState.dart';
import 'package:cgv_clone/string/AppString.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AccountRepository accountRepository;
  final AuthenticateRepository authenticateRepository;

  ProfileBloc(
      {@required this.accountRepository,
      @required this.authenticateRepository});

  @override
  // TODO: implement initialState
  ProfileState get initialState => ProfileInital();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ProfileStarted) {
      yield ProfileLoading();
      AccountModel account = await accountRepository.info();
      if (account != null) {
        if (account.status == 'ok')
          yield ProfileLoaded(account: account);
        else
          yield ProfileFailure(msg: AppString.someWrong);
      } else
        yield ProfileFailure(msg: AppString.connectError);
    }
    if (event is LogoutButtonPressed) {
      yield LogoutLoading();
      LogoutModel logout = await accountRepository.logout();
      print(logout);
      if (logout != null) {
        if (logout.status == 'ok') {
          //yield LogoutLoaded();
          await authenticateRepository.deleteToken();
          Navigator.of(event.context)
              .popUntil((r) => r.settings.isInitialRoute);
        } else
          yield LogoutFailure(msg: AppString.someWrong);
      } else
        yield LogoutFailure(msg: AppString.connectError);
    }
  }
}
