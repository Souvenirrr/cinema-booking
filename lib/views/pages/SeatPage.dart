import 'package:cgv_clone/blocs/CartBloc.dart';
import 'package:cgv_clone/blocs/SeatBLoc.dart';
import 'package:cgv_clone/blocs/WalletBLoc.dart';
import 'package:cgv_clone/business/remote/Pay.dart';
import 'package:cgv_clone/events/CartEvent.dart';
import 'package:cgv_clone/events/SeatEvent.dart';
import 'package:cgv_clone/events/WalletEvent.dart';
import 'package:cgv_clone/models/AccountModel.dart';
import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:cgv_clone/models/PageSeatArgs.dart';
import 'package:cgv_clone/models/SeatModel.dart';
import 'package:cgv_clone/states/CartState.dart';
import 'package:cgv_clone/states/SeatState.dart';
import 'package:cgv_clone/states/WalletState.dart';
import 'package:cgv_clone/string/AppString.dart';
import 'package:cgv_clone/string/DialogType.dart';
import 'package:cgv_clone/views/Theme.dart';
import 'package:cgv_clone/views/frags/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

double _width, _height;
Map<String, double> seatItemSize = {'width': 0.0, 'height': 0.0, 'margin': 0.0};
Map<String, Seats> _selectedSeats = Map();
final _maxSelect = 8;
bool _isLoadedPaymentInfo = false;
SeatBloc _seatBloc;
WalletBloc _walletBloc;
CartBloc _cartBloc;

class SeatPage extends StatefulWidget {
  final PageSeatArgs pageSeatArgs;
  SeatPage({@required this.pageSeatArgs});
  @override
  _SeatPageState createState() =>
      _SeatPageState(pageSeatArgs: this.pageSeatArgs);
}

class _SeatPageState extends State<SeatPage> {
  final PageSeatArgs pageSeatArgs;
  _SeatPageState({@required this.pageSeatArgs});
  ScrollController hScrollCtrl;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _selectedSeats.clear();
    _isLoadedPaymentInfo = false;
    _seatBloc = null;
    _walletBloc = null;
    _cartBloc = null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seatBloc = BlocProvider.of<SeatBloc>(context);
    _walletBloc = BlocProvider.of<WalletBloc>(context);
    _cartBloc = BlocProvider.of<CartBloc>(context);

    _walletBloc.add(WalletLoadStarted());
    _seatBloc.add(SeatLoadStarted(scheduleID: pageSeatArgs.time.scheduleId));
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    seatItemSize['width'] = (_width / 100) * 8.0;
    seatItemSize['height'] = (_width / 100) * 8.0;
    seatItemSize['margin'] = 5.0;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _screen(),
            ),
            Expanded(
              flex: 7,
              child: BlocBuilder<SeatBloc, SeatState>(
                builder: (context, seatState) {
                  if (seatState is SeatsLoaded) return _seats(seatState.seats);
                  return LoadingWidget();
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Payable(
                movieDetail: pageSeatArgs.movieDetail,
                pageSeatArgs: pageSeatArgs,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align _screen() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: (_width / 100) * 90,
        height: (_height / 100) * 5,
        decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.all(Radius.circular(55))),
        child: Text(
          AppString.manhinh,
          style:
              TextStyle(color: AppTheme.onSurface, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Container _seats(SeatModel seats) {
    final List<SeatRows> seatRows = seats.seatRows;
    final List<Widget> seatsWidget = List();
    int maxSeatOfRow = 0;
    seatRows.forEach((row) {
      if (row.seats.length > maxSeatOfRow) maxSeatOfRow = row.seats.length;
      seatsWidget.add(Row(
        children: row.seats
            .map((seat) => SeatItem(
                  row: row.row,
                  seats: seat,
                  pageSeatArgs: pageSeatArgs,
                ))
            .toList(),
      ));
    });
    final double w2OfRow = (seatItemSize['width'] * maxSeatOfRow +
            seatItemSize['margin'] * (2 * maxSeatOfRow)) /
        2;
    final double w2OfScreen = _width / 2;
    hScrollCtrl = ScrollController(initialScrollOffset: w2OfRow - w2OfScreen);
    return Container(
        alignment: Alignment.center,
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            controller: hScrollCtrl,
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: seatsWidget,
            ),
          ),
        ));
  }
}

class SeatItem extends StatefulWidget {
  final String row;
  final Seats seats;
  final PageSeatArgs pageSeatArgs;
  SeatItem(
      {@required this.row, @required this.seats, @required this.pageSeatArgs});
  @override
  _SeatItemState createState() =>
      _SeatItemState(seat: this.seats, row: this.row);
}

class _SeatItemState extends State<SeatItem> {
  final String row;
  final Seats seat;
  bool selected = false;
  _SeatItemState({@required this.row, @required this.seat});

  _onSeatItemTap() {
    if (!seat.seatStatus && _isLoadedPaymentInfo) {
      setState(() {
        if (_selectedSeats.keys.length <= _maxSelect)
          selected = !selected;
        else
          selected = false;
        if (_selectedSeats.keys.length == _maxSelect) selected = false;
      });
      if (selected)
        _selectedSeats.putIfAbsent(seat.seatId, () => seat);
      else if (_selectedSeats.containsKey(seat.seatId))
        _selectedSeats.remove(seat.seatId);

      if (_selectedSeats.keys.length <= _maxSelect) {
        print('selected seat');
        _cartBloc.add(CartChanged(
            selectedSeats: _selectedSeats, point: 0, valueOf1Point: 0));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onSeatItemTap();
      },
      child: Container(
        width: seatItemSize['width'],
        height: seatItemSize['height'],
        margin: EdgeInsets.all(seatItemSize['margin']),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: seat.seatStatus
                ? Colors.redAccent.withOpacity(0.6)
                : selected ? Colors.blue : AppTheme.surfaceColor,
            borderRadius: BorderRadius.all(Radius.circular(0))),
        child: Text(
          row + seat.number.toString(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class Payable extends StatefulWidget {
  final PageSeatArgs pageSeatArgs;
  final MovieDetailModel movieDetail;
  Payable({@required this.movieDetail, @required this.pageSeatArgs});
  @override
  _PayableState createState() => _PayableState(
      movieDetail: this.movieDetail, pageSeatArgs: this.pageSeatArgs);
}

class _PayableState extends State<Payable> {
  final MovieDetailModel movieDetail;
  final PageSeatArgs pageSeatArgs;
  _PayableState({@required this.movieDetail, @required this.pageSeatArgs});
  final formatCurrency = new NumberFormat('#,##0', 'en_US');
  double _pointUsed = 0;
  Pay _pay = Pay();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            color: AppTheme.surfaceColor),
        child: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, cartState) {
            if (cartState is WalletLoaded) {
              _isLoadedPaymentInfo = true;
              return _cart(cartState.wallet);
            }
            return LoadingWidget();
          },
        ));
  }

  Widget _cart(AccountModel wallet) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _film(wallet),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 1,
          child: _payment(wallet),
        )
      ],
    ));
  }

  Container _payment(AccountModel wallet) {
    return Container(
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, payState) {
          if (payState is CartLoaded) {
            return _money(
                payState.selectedSeats,
                payState.selectedSeats.keys.length,
                payState.totalPriceWithPoint,
                payState.totalPriceWithoutPoint,
                wallet,
                payState.point);
          }
          return _money(null, 0, 0, 0, wallet, 0);
        },
      ),
    );
  }

  Widget _money(
      Map<String, Seats> selectedSeats,
      int seatLength,
      double totalPriceWithPoint,
      double totalPriceWithoutPoint,
      AccountModel wallet,
      double point) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: _cartMoney(selectedSeats, seatLength, totalPriceWithPoint,
                  totalPriceWithoutPoint, wallet)),
          Expanded(
              flex: 1,
              child: _walletMoney(
                wallet,
              ))
        ],
      ),
    );
  }

  Widget _cartMoney(
      Map<String, Seats> selectedSeats,
      int seatLength,
      double totalPriceWithPoint,
      double totalPriceWithoutPoint,
      AccountModel wallet) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Align(
              alignment: Alignment.topLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  seatLength != null &&
                          totalPriceWithPoint != null &&
                          selectedSeats != null
                      ? seatLength.toString() +
                          ' ' +
                          AppString.ghe +
                          ': ' +
                          formatCurrency.format(totalPriceWithPoint) +
                          ' ' +
                          AppString.vnd
                      : '0 ' + AppString.ghe + ': 0 ' + AppString.vnd,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              )),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: FittedBox(
                    alignment: Alignment.topLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      AppString.point,
                      style: TextStyle(color: AppTheme.onSurface),
                    ),
                  )),
              Expanded(
                flex: 7,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SliderTheme(
                    data: SliderThemeData(
                        thumbColor: wallet != null &&
                                seatLength != null &&
                                totalPriceWithPoint != null &&
                                selectedSeats != null
                            ? AppTheme.onSurface
                            : AppTheme.backgroundColor,
                        trackHeight: 2,
                        inactiveTrackColor: wallet != null &&
                                seatLength != null &&
                                totalPriceWithPoint != null &&
                                selectedSeats != null
                            ? AppTheme.onSurface.withOpacity(0.1)
                            : AppTheme.backgroundColor,
                        activeTrackColor: wallet != null &&
                                seatLength != null &&
                                totalPriceWithPoint != null &&
                                selectedSeats != null
                            ? AppTheme.onSurface
                            : AppTheme.backgroundColor,
                        overlayColor: Colors.transparent),
                    child: Slider(
                      min: 0,
                      max: wallet != null
                          ? wallet.point >
                                  totalPriceWithoutPoint / wallet.valueOf1Point
                              ? totalPriceWithoutPoint / wallet.valueOf1Point
                              : wallet.point
                          : 0,
                      onChanged: (double value) {
                        if (wallet != null &&
                            seatLength != null &&
                            totalPriceWithPoint != null &&
                            selectedSeats != null) {
                          setState(() {
                            _pointUsed = value;
                          });
                          _cartBloc.add(CartChanged(
                              selectedSeats: _selectedSeats,
                              point: _pointUsed,
                              valueOf1Point: wallet.valueOf1Point.toDouble()));
                        }
                      },
                      value: wallet != null &&
                              seatLength != null &&
                              totalPriceWithoutPoint != null &&
                              selectedSeats != null
                          ? _pointUsed >
                                  totalPriceWithoutPoint / wallet.valueOf1Point
                              ? _pointUsed =
                                  totalPriceWithoutPoint / wallet.valueOf1Point
                              : _pointUsed
                          : 0,
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: FittedBox(
                    alignment: Alignment.topLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _pointUsed.toStringAsFixed(0) +
                          '/' +
                          (wallet != null ? wallet.point.toString() : '0'),
                      style: TextStyle(color: AppTheme.onSurface),
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }

  Widget _walletMoney(AccountModel wallet) {
    return Align(
      alignment: Alignment.topCenter,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          AppString.sodu +
              '\n' +
              (wallet != null
                  ? formatCurrency.format(double.parse(wallet.money))
                  : '0'),
          style: TextStyle(
              color: AppTheme.onBackground, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _film(AccountModel wallet) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          movieDetail.movieName,
                          style: TextStyle(
                            color: AppTheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                        decoration: BoxDecoration(
                          color: AppTheme.onSurface.withOpacity(0.7),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            movieDetail.movieCens,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          movieDetail.movieFormat,
                          style: TextStyle(
                              color: AppTheme.onSurface.withOpacity(0.7)),
                        ),
                      ),
                    ],
                  )
                ],
              )),
          Expanded(flex: 1, child: _payButton())
        ],
      ),
    );
  }

  Padding _payButton() {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: RaisedButton(
        elevation: 0,
        onPressed: () {
          print('wallet ');
          final state = _cartBloc.state;
          if (state is CartLoaded) {
            _walletBloc.add(PayButtonPressed(
                selectedSeats: state.selectedSeats, point: _pointUsed));
          }
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: Colors.orange,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            AppString.thanhtoan,
            style: TextStyle(color: AppTheme.onSurface),
          ),
        ),
      ),
    );
  }
}
