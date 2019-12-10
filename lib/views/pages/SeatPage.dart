import 'package:cgv_clone/blocs/CartBloc.dart';
import 'package:cgv_clone/blocs/PayBloc.dart';
import 'package:cgv_clone/blocs/SeatBLoc.dart';
import 'package:cgv_clone/blocs/WalletBLoc.dart';
import 'package:cgv_clone/events/CartEvent.dart';
import 'package:cgv_clone/events/PayEvent.dart';
import 'package:cgv_clone/events/SeatEvent.dart';
import 'package:cgv_clone/events/WalletEvent.dart';
import 'package:cgv_clone/models/AccountModel.dart';
import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:cgv_clone/models/PageSeatArgs.dart';
import 'package:cgv_clone/models/SeatModel.dart';
import 'package:cgv_clone/repsitories/AccountRepository.dart';
import 'package:cgv_clone/repsitories/AuthenticateRepository.dart';
import 'package:cgv_clone/repsitories/PayRepository.dart';
import 'package:cgv_clone/repsitories/SeatRepository.dart';
import 'package:cgv_clone/states/CartState.dart';
import 'package:cgv_clone/states/PayState.dart';
import 'package:cgv_clone/states/SeatState.dart';
import 'package:cgv_clone/states/WalletState.dart';
import 'package:cgv_clone/string/AppString.dart';
import 'package:cgv_clone/string/DialogType.dart';
import 'package:cgv_clone/views/Theme.dart';
import 'package:cgv_clone/views/frags/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

double _width, _height;
Map<String, double> seatItemSize = {'width': 0.0, 'height': 0.0, 'margin': 0.0};
Map<String, Seats> _selectedSeats = Map();
final _maxSelect = 8;
bool _isLoadedPaymentInfo = false;
SeatBloc _seatBloc;
WalletBloc _walletBloc;
CartBloc _cartBloc;
PayBloc _payBloc;
double _pointUsed = 0;

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
    _payBloc = null;
    _pointUsed = 0;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seatBloc = SeatBloc(seatRepository: SeatRepository());
    _walletBloc = WalletBloc(accountRepository: AccountRepository());
    _cartBloc = CartBloc();
    _payBloc = PayBloc(
        payRepository: PayRepository(),
        authenticateRepository: AuthenticateRepository());

    _walletBloc.add(WalletLoadStarted());
    _seatBloc.add(SeatLoadStarted(scheduleID: pageSeatArgs.time.scheduleID));
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
        title: Text(AppString.cost),
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
                bloc: _seatBloc,
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
          AppString.bigScreen,
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
        if (_selectedSeats.keys.length <= _maxSelect) {
          selected = !selected;
          _pointUsed = 0;
        } else
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

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            color: AppTheme.surfaceColor),
        child: BlocBuilder<WalletBloc, WalletState>(
          bloc: _walletBloc,
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
        bloc: _cartBloc,
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
                          AppString.movieChair +
                          ': ' +
                          AppString.formatCurrency.format(totalPriceWithPoint) +
                          ' ' +
                          AppString.vnd
                      : '0 ' + AppString.movieChair + ': 0 ' + AppString.vnd,
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
                            ? wallet.info.point >
                                    totalPriceWithoutPoint /
                                        wallet.info.valueOf1Point
                                ? totalPriceWithoutPoint /
                                    wallet.info.valueOf1Point
                                : wallet.info.point
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
                                point:
                                    double.parse(_pointUsed.toStringAsFixed(0)),
                                valueOf1Point:
                                    wallet.info.valueOf1Point.toDouble()));
                          }
                        },
                        value: _pointUsed),
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
                          (wallet != null ? wallet.info.point.toString() : '0'),
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
          AppString.walletMoney +
              '\n' +
              (wallet != null
                  ? AppString.formatCurrency
                      .format(double.parse(wallet.info.money))
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
                          movieDetail.data.movieName,
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
                            movieDetail.data.movieCens,
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
                          movieDetail.data.movieForm,
                          style: TextStyle(
                              color: AppTheme.onSurface.withOpacity(0.7)),
                        ),
                      ),
                    ],
                  )
                ],
              )),
          Expanded(flex: 1, child: _payButton(wallet))
        ],
      ),
    );
  }

  Padding _payButton(AccountModel wallet) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: RaisedButton(
        elevation: 0,
        onPressed: () {
          final state = _cartBloc.state;
          if (state is CartLoaded && state.selectedSeats.keys.length > 0) {
            if (state.totalPriceWithPoint < double.parse(wallet.info.money)) {
              _showDialog(DialogType.confirm, {
                'title': AppString.payConfirm,
                'content': AppString.dialogTicket(
                    AppString.formatCurrency
                        .format(state.totalPriceWithPoint)
                        .toString(),
                    state.selectedSeats.keys.length),
                'action_1': AppString.cancel,
                'action_2': AppString.pay,
                'point': _pointUsed,
                'scheduleID': pageSeatArgs.time.scheduleID,
                'selectedSeats': state.selectedSeats
              });
            } else {
              print('Khong du so du');
              _showDialog(
                  DialogType.error, {'title': AppString.notEnoughMoney});
            }
          }
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: Colors.orange,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            AppString.pay,
            style: TextStyle(color: AppTheme.onSurface),
          ),
        ),
      ),
    );
  }

  _showDialog(DialogType dialogType, args) {
    showDialog(
        context: context,
        // ignore: missing_return
        builder: (context) {
          if (dialogType == DialogType.confirm) return _confirm(args);
          if (dialogType == DialogType.success) return _success(args);
          if (dialogType == DialogType.loading) return _loading(args);
          if (dialogType == DialogType.error) return _error(args);
        });
  }

  AlertDialog _confirm(args) {
    return AlertDialog(
      title: Text(args['title']),
      content: BlocBuilder<PayBloc, PayState>(
        bloc: _payBloc,
        builder: (context, payState) {
          if (payState is Payed) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showDialog(DialogType.success, {'title': AppString.paySuccess});
            });
          }
          return Text(args['content']);
        },
      ),
      backgroundColor: AppTheme.onBackground,
      actions: <Widget>[
        // Cancel
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(args['action_1']),
        ),
        // Accept
        FlatButton(
          onPressed: () {
            //Navigator.pop(context);
            _showDialog(DialogType.loading, {'title': AppString.pleaseWait});
            _payBloc.add(ConfirmButtonPressed(
                point: args['point'],
                scheduleID: args['scheduleID'],
                selectedSeats: args['selectedSeats'],
                context: context));
          },
          child: Text(args['action_2']),
        ),
      ],
    );
  }

  Widget _success(args) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: (_width / 100) * 80,
            height: (_height / 100) * 30,
            decoration: BoxDecoration(
                color: AppTheme.onBackground,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.done,
                    size: (_width / 100) * 20,
                    color: Colors.green,
                  ),
                  Text(
                    args['title'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  _homeButton()
                ],
              ),
            ),
          ),
        ));
  }

  Widget _error(args) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: (_width / 100) * 80,
            height: (_height / 100) * 30,
            decoration: BoxDecoration(
                color: AppTheme.onBackground,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.error,
                    size: (_width / 100) * 20,
                    color: Colors.red,
                  ),
                  Text(
                    args['title'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  _exitButton()
                ],
              ),
            ),
          ),
        ));
  }

  Align _homeButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: Colors.green,
        onPressed: () {
          Navigator.of(context).popUntil((r) => r.settings.isInitialRoute);
        },
        child: Text(
          'Trang chủ',
          style: TextStyle(color: AppTheme.onBackground),
        ),
      ),
    );
  }

  Align _exitButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: Colors.red,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          'Thoát',
          style: TextStyle(color: AppTheme.onBackground),
        ),
      ),
    );
  }

  Widget _loading(args) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: (_width / 100) * 80,
            height: (_height / 100) * 30,
            decoration: BoxDecoration(
                color: AppTheme.onBackground,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  LoadingWidget(
                    color: Colors.green,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      args['title'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
