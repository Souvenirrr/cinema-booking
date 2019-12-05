import 'dart:async';

class SeatStream {
  final StreamController ctrl = StreamController.broadcast();

  changeSeat(seats) {
    ctrl.add(seats);
  }
}
