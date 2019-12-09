import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/RegisterEvent.dart';
import 'package:cgv_clone/models/AccountModel.dart';
import 'package:cgv_clone/repsitories/AccountRepository.dart';
import 'package:cgv_clone/repsitories/AuthenticateRepository.dart';
import 'package:cgv_clone/states/RegisterState.dart';
import 'package:cgv_clone/string/AppString.dart';
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
        if (accountModel.status == 'ok') {
          if (await authenticateRepository.saveToken(accountModel.token))
            yield RegisterSuccess();
          else
            yield RegisterFailure(msg: AppString.loiluutoken);
        } else
          yield RegisterFailure(msg: AppString.saitaikhoan);
      } else
        yield RegisterFailure(msg: AppString.loiconnect);
    }
  }
}
