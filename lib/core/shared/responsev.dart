import 'dart:math' show min;
import 'package:flutter/material.dart';

class Responsive {
  static const Size defaultSize = Size(1080, 1920);
  static final Responsive _singleton = Responsive._();
  static Responsive get instance => _singleton;
  Responsive._();
  Size uiSize = defaultSize;
  bool allowFontScaling = false;
  static late double _pixelRatio;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _statusBarHeight;
  static late double _bottomBarHeight;
  static late double _textScaleFactor;
  static bool isInit = false;
  static void init(BuildContext context,
      {Size designSize = defaultSize, bool allowFontScaling = false}) {
    if (isInit == true) {
      return;
    }
    isInit = true;
    instance
      ..uiSize = designSize
      ..allowFontScaling = allowFontScaling;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.shortestSide;
    _screenHeight = mediaQuery.size.longestSide;
    _pixelRatio = _screenWidth / _screenHeight;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  double get textScaleFactor => _textScaleFactor;
  double get pixelRatio => _pixelRatio;
  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;
  double get screenWidthPx => _screenWidth * _pixelRatio;
  double get screenHeightPx => _screenHeight * _pixelRatio;
  double get statusBarHeight => _statusBarHeight;
  double get bottomBarHeight => _bottomBarHeight;
  double get scaleWidth => _screenWidth / uiSize.width;
  double get scaleHeight => _screenHeight / uiSize.height;
  double get scaleText => scaleWidth;
  double setWidth(num width) => width * scaleWidth;
  double setHeight(num height) => height * scaleHeight;
  double setSp(num fontSize, {bool allowFontScalingSelf = true}) {
    double size = fontSize.toDouble();
    size = fontSize * scaleText;
    if (_screenWidth > 550) {
      return size * 0.8;
    } else {
      return size;
    }
  }
}

extension SizeExtension on num {
  ///[ScreenUtil.setWidth]
  double get w => Responsive.instance.setWidth(this);

  ///[ScreenUtil.setHeight]
  double get h => Responsive.instance.setHeight(this);

  ///[ScreenUtil.setSp]
  double get sp => Responsive.instance.setSp(this);

  ///smart size :  it check your value - if it is bigger than your value it will set your value
  ///for example, you have set 16.sm() , if for your screen 16.sp() is bigger than 16 , then it will set 16 not 16.sp()
  ///I think that it is good for save size balance on big sizes of screen
  double get sm => min(toDouble(), sp);

  ///Multiple of screen width
  double get sw => Responsive.instance.screenWidth * this;

  ///Multiple of screen height
  double get sh => Responsive.instance.screenHeight * this;
}

int getAxisCount(double width) {
  if (width < 500) {
    return 2;
  }
  return width ~/ 250;
}

int getCardsCount(double width) {
  if (width < 500) {
    return 1;
  }
  return 2;
}

int getCustomerAxisCount(double width) {
  if (width > 500) {
    return 2;
  }
  return 1;
}

double getCustomerButtonSheetWidth(double width) {
  if (width > 500) {
    return width / 2.2;
  }
  return width - (25.h);
}
