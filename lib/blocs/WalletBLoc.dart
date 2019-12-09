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
  WalletState get initialState => WalletInital();

  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    // TODO: implement mapEventToState
    if (event is WalletLoadStarted) {
      final AccountModel wallet = await accountRepository.info();
      if (wallet != null)
        yield WalletLoaded(wallet: wallet);
      else
        yield WalletFailure(msg: 'Error');
    }
  }
}
