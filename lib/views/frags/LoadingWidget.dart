import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;
  LoadingWidget({this.color});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
            this.color == null ? Colors.white : this.color),
      ),
    );
  }
}
