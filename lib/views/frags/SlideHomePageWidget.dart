import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cgv_clone/blocs/SlideBloc.dart';
import 'package:cgv_clone/events/SlideEvent.dart';
import 'package:cgv_clone/models/SlideModel.dart';
import 'package:cgv_clone/states/SlideState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'LoadingWidget.dart';

class SlideHomePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SlideHomePageWidgetState();
  }
}

class _SlideHomePageWidgetState extends State<SlideHomePageWidget> {
  PageController _pageController = PageController();
  Timer _timer;
  Duration duration = Duration(seconds: 4);
  int _currentPage = 0;
  List<Widget> _slides = List();
  SlideBloc _slideBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _slideBloc = BlocProvider.of<SlideBloc>(context);
    _slideBloc.add(SlideStarted());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<SlideBloc, SlideState>(
      builder: (context, slideStage) {
        if (slideStage is SlideLoading) return LoadingWidget();
        if (slideStage is SlideLoaded) return _slidesLayout(slideStage.slides);
        return LoadingWidget();
      },
    );
  }

  Widget _slidesLayout(SlideModel slides) {
    return Container(
      child: BlocBuilder<SlideBloc, SlideState>(
        builder: (context, slideState) {
          if (slideState is SlideLoaded) {
            slides.slides.forEach((value) {
              _slides.add(Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(value.slidesImgUrl))),
              ));
            });
            _autoSwipe();

            return PageView.builder(
              itemCount: _slides.length,
              controller: _pageController,
              onPageChanged: (pageIndex) {
                _currentPage = pageIndex;
                _autoSwipe();
              },
              itemBuilder: (BuildContext context, int index) {
                return _slides[index];
              },
            );
          }
          return LoadingWidget();
        },
      ),
    );
  }

  _autoSwipe() {
    if (_timer != null && _timer.isActive) _timer.cancel();

    _timer = Timer.periodic(duration, (timer) {
      _currentPage++;
      if (_currentPage >= _slides.length) _currentPage = 0;

      _pageController.animateToPage(_currentPage,
          duration: Duration(seconds: 1), curve: Curves.easeInOutQuint);
    });
  }
}
