import 'package:cgv_clone/models/MovieDetailModel.dart';
import 'package:cgv_clone/views/Theme.dart';
import 'package:flutter/material.dart';

class MovieDetailInfo extends StatelessWidget {
  final MovieDetailModel movieDetailData;

  MovieDetailInfo({this.movieDetailData});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  'Thể loại',
                  style: TextStyle(
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  movieDetailData.data.movieCens,
                  style: TextStyle(
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  'Định dạng',
                  style: TextStyle(
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  movieDetailData.data.movieForm,
                  style: TextStyle(
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  'Thời lượng',
                  style: TextStyle(
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  movieDetailData.data.movieLeng,
                  style: TextStyle(
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  'Ngày phát hành',
                  style: TextStyle(
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  movieDetailData.data.movieRele,
                  style: TextStyle(
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
