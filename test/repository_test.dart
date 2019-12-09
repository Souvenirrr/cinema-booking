import 'package:cgv_clone/models/AccountModel.dart';
import 'package:cgv_clone/repsitories/AccountRepository.dart';

main() {
  _loginRepository();
  _registerRepository();
}

_loginRepository() async {
  AccountRepository accountRepository = AccountRepository();
  AccountModel request = await accountRepository.login('0916512987', '123456');
  print({request.status});
}

_registerRepository() async {
  AccountRepository accountRepository = AccountRepository();
  AccountModel request = await accountRepository.register('mducc', '0376460699',
      '123456', 'duc@gmail.com', 'male', '25/2/1997', '1234', '1234');
  print({request.status});
}
