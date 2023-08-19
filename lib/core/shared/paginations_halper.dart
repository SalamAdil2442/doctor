import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:tandrustito/core/shared/imports.dart';

bool onScroll(ScrollNotification notification, Pagination paginations,
    ScrollController scrollController, Status status, Function onLoad) {
  try {
    if (notification is ScrollUpdateNotification &&
        scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      final double diff =
          scrollController.position.maxScrollExtent - scrollController.offset;
      if (diff <= 50) {
        if (paginations.isNotMatch && !status.isLoading && !status.isInitial) {
          onLoad();
        }
      }
    }
    return true;
  } catch (e) {
    return false;
  }
}
