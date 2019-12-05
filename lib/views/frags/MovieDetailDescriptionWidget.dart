import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:flutter/material.dart';

import '../Theme.dart';

class MovieDetailDescriptionWidget extends StatelessWidget {
  final MovieDetailModel movieDetailData;
  MovieDetailDescriptionWidget({this.movieDetailData});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Text(
        movieDetailData.movieDescription,
        style: TextStyle(
            color: AppTheme.onSurface,
            fontWeight: FontWeight.w400,
            fontSize: 16),
      ),
    );
  }
}
