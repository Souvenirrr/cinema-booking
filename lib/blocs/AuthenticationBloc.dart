import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/AuthenticationEvent.dart';
import 'package:cgv_clone/repsitories/AuthenticateRepository.dart';
import 'package:cgv_clone/states/AuthenticationState.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticateRepository _authenticateRepository;
  @override
  // TODO: implement initialState
  AuthenticationState get initialState => AuthenticateInital();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    // TODO: implement mapEventToState
    if (event is AuthenticateStarted) {
      yield AuthenticateLoading();
      if (await _authenticateRepository.readToken() != false &&
          await _authenticateRepository.isExpired() == false) {
        yield Authenticated();
      }
      else
        yield AuthenticateFailure(msg: 'Token is expired');
    }
  }
}
