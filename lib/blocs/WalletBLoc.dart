import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/WalletEvent.dart';
import 'package:cgv_clone/models/AccountModel.dart';
import 'package:cgv_clone/repsitories/AccountRepository.dart';
import 'package:cgv_clone/repsitories/PayRepository.dart';
import 'package:cgv_clone/states/WalletState.dart';
import 'package:meta/meta.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final AccountRepository accountRepository;
  final PayRepository payRepository;
  WalletBloc({@required this.accountRepository, this.payRepository});

  @override
  // TODO: implement initialState
  WalletState get initialState => PayInital();

  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    // TODO: implement mapEventToState
    if (event is WalletLoadStarted) {
      final AccountModel wallet = await accountRepository.fetch();
      yield WalletLoaded(wallet: wallet);
    }
    if (event is PayButtonPressed) {
      print(event.point);
      print(event.selectedSeats.keys.length);
    }
  }
}