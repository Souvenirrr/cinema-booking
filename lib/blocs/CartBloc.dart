import 'package:bloc/bloc.dart';
import 'package:cgv_clone/events/CartEvent.dart';
import 'package:cgv_clone/states/CartState.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  @override
  // TODO: implement initialState
  CartState get initialState => CartInital();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    // TODO: implement mapEventToState
    if (event is CartChanged) {
      double totalPriceWithPoint = 0;
      double totalPriceWithoutPoint = 0;

      event.selectedSeats.forEach((key, value) {
        totalPriceWithPoint += value.price.toDouble();
        totalPriceWithoutPoint += value.price.toDouble();
      });

      if (totalPriceWithPoint >= event.point * event.valueOf1Point)
        totalPriceWithPoint -= event.point * event.valueOf1Point;
      else
        totalPriceWithPoint = 0;

      //print('totalPrice $totalPrice');
      yield CartLoaded(
          selectedSeats: event.selectedSeats,
          totalPriceWithPoint: totalPriceWithPoint,
          totalPriceWithoutPoint: totalPriceWithoutPoint,
          point: event.point);
    }
  }
}
