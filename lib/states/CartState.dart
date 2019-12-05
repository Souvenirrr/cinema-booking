import 'package:cgv_clone/models/SeatModel.dart';
import 'package:meta/meta.dart';

class CartState {}

class CartInital extends CartState {}

class CartLoaded extends CartState {
  final Map<String, Seats> selectedSeats;
  final double totalPriceWithoutPoint;
  final double totalPriceWithPoint;
  CartLoaded({@required this.selectedSeats, @required this.totalPriceWithoutPoint, @required this.totalPriceWithPoint});
}
