import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/PayEvent.dart';
import 'package:cgv_clone/models/PaymentModel.dart';
import 'package:cgv_clone/navigate/GenarateRouter.dart';
import 'package:cgv_clone/repsitories/AuthenticateRepository.dart';
import 'package:cgv_clone/repsitories/PayRepository.dart';
import 'package:cgv_clone/states/PayState.dart';
import 'package:cgv_clone/string/AppString.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  final PayRepository payRepository;
  final AuthenticateRepository authenticateRepository;

  PayBloc(
      {@required this.payRepository, @required this.authenticateRepository});

  @override
  // TODO: implement initialState
  PayState get initialState => PayInital();

  @override
  Stream<PayState> mapEventToState(PayEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ConfirmButtonPressed) {
      print(event.point);
      print(event.selectedSeats.keys.length);
      var token = await authenticateRepository.readToken();
      if (token != false) {
        if (await authenticateRepository.isExpired() == false) {
          PaymentModel payment = await payRepository.pay(
              event.scheduleID,
              event.point,
              event.selectedSeats.entries
                  .map((ele) => ele.value.seatId)
                  .toList(),
              token);

          if (payment != null)
            yield Payed(
              totalPrice: null,
              selectedSeats: null,
            );
          else
            yield PayFailure(msg: AppString.someWrong);
        } else {
          authenticateRepository.deleteToken();
          Navigator.of(event.context)
              .popUntil((r) => r.settings.isInitialRoute);
          Navigator.of(event.context).pushNamed(RouterNames.account);
        }
      }
    }
  }
}
