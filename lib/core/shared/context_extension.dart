import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';

extension ContextExtension on BuildContext {
  Color get primaryColor2 => const Color.fromARGB(255, 230, 141, 7);
  back() {
    if (Navigator.of(this).canPop()) {
      Navigator.of(this).pop();
    }
  }

  Color get primaryColor => Theme.of(this).primaryColor;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get iconColor => Theme.of(this).iconTheme.color!;
  Color get canvacColor => Theme.of(this).canvasColor;
  Color get cardColor =>
      Theme.of(this).cardTheme.color ?? Theme.of(this).cardColor;
  TextDirection get textDirection => Directionality.of(this);
  bool get isEn {
    logger("textDirection $textDirection");
    return textDirection == TextDirection.ltr;
  }

  Color get unSelectedColor => Theme.of(this).unselectedWidgetColor;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color? get buttonColor =>
      Theme.of(this).elevatedButtonTheme.style?.backgroundColor?.resolve({});
  Color? get buttonTextColor =>
      Theme.of(this).elevatedButtonTheme.style?.textStyle?.resolve({})?.color;

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get longestSide => MediaQuery.of(this).size.longestSide;
  double get shortestSide => MediaQuery.of(this).size.shortestSide;

  Color get iconBtnColor => primaryColor;

  TextStyle get titleStyle {
    return (Theme.of(this).textTheme.bodyLarge ??
            const TextStyle(color: Colors.black))
        .copyWith(fontSize: 18.sp);
  }

  TextStyle get appBarTitleStyle {
    return (Theme.of(this).appBarTheme.titleTextStyle ??
            const TextStyle(color: Colors.black))
        .copyWith(fontSize: 18.sp);
  }

  TextStyle get subtitle1Style {
    return (Theme.of(this).textTheme.titleMedium ??
            const TextStyle(color: Colors.white))
        .copyWith(fontSize: 20.sp);
  }

  TextStyle get headLine1 =>
      (Theme.of(this).textTheme.displayLarge ?? const TextStyle())
          .copyWith(fontSize: 20.sp);
  TextStyle get subTitleStyle =>
      (Theme.of(this).textTheme.bodyMedium ?? const TextStyle())
          .copyWith(fontSize: 15.sp);
  to(Widget widget, {bool withCup = false}) {
    if (withCup != true) {
      Navigator.push(this, MaterialPageRoute(builder: (_) => widget));
    } else {
      {
        Navigator.push(this, CupertinoPageRoute(builder: (_) => widget));
      }
    }
  }

  bool get isLandScane =>
      MediaQuery.of(this).orientation == Orientation.landscape;
  Size get size => MediaQuery.of(this).size;
}
