import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/PayEvent.dart';
import 'package:cgv_clone/models/PaymentModel.dart';
import 'package:cgv_clone/repsitories/PayRepository.dart';
import 'package:cgv_clone/states/PayState.dart';
import 'package:meta/meta.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  final PayRepository payRepository;
  PayBloc({@required this.payRepository});
  @override
  // TODO: implement initialState
  PayState get initialState => PayInital();

  @override
  Stream<PayState> mapEventToState(PayEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ConfirmButtonPressed) {
      print(event.point);
      print(event.selectedSeats.keys.length);
      PaymentModel payment = await payRepository.pay(
          event.scheduleID,
          event.point,
          event.selectedSeats.entries.map((ele) => ele.value.seatId).toList());
      if (payment != null)
        yield Payed(
          totalPrice: null,
          selectedSeats: null,
        );
      else
        yield PayFailure(msg: 'Error');
    }
  }
}
