import 'package:cgv_clone/models/SeatModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class PayEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ConfirmButtonPressed extends PayEvent {
  final String scheduleID;
  final Map<String, Seats> selectedSeats;
  final double point;
  final BuildContext context;

  ConfirmButtonPressed(
      {@required this.selectedSeats,
      @required this.point,
      @required this.scheduleID,
      @required this.context});

  @override
  // TODO: implement props
  List<Object> get props => [selectedSeats, point];
}
