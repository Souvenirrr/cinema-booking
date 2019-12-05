import 'package:cgv_clone/models/SeatModel.dart';
import 'package:meta/meta.dart';

class CartEvent {}

class CartChanged extends CartEvent {
  final Map<String, Seats> selectedSeats;
  final double point;
  final double valueOf1Point;
  CartChanged(
      {@required this.selectedSeats,
      @required this.point,
      @required this.valueOf1Point});
}
