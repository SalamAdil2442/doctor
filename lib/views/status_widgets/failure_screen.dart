import 'package:flutter/material.dart';
import 'package:tandrustito/core/error/failures.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/status_widgets/falied_load_page_widget.dart';
import 'package:tandrustito/views/status_widgets/network_error_widget.dart';
import 'package:tandrustito/views/status_widgets/no_data_found_widget.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({
    Key? key,
    required this.failure,
    required this.onRefresh,
  }) : super(key: key);
  final Failure failure;
  final Future<void> Function() onRefresh;
  @override
  Widget build(BuildContext context) {
    final String reason = failure.error.reason;
    if ((failure is NetworkFailure)) {
      return NetWorkErrorWidget(onPress: onRefresh, text: reason);
    } else if ((failure is ErrorFailure)) {
      return FaliedLoadPageWIdget(onPress: onRefresh, text: reason);
    } else if ((failure is UnAuthFailure)) {
      return FaliedLoadPageWIdget(onPress: onRefresh, text: reason);
    } else if ((failure is ServerFailure)) {
      return FaliedLoadPageWIdget(onPress: onRefresh, text: reason);
    } else if ((failure is EmptyData)) {
      return NoDataFound(
          onRefresh: onRefresh,
          text: Trans.noDataFound.trans(context: context));
    } else {
      return FaliedLoadPageWIdget(
          onPress: onRefresh,
          text: Trans.failedLoadData.trans(context: context));
    }
  }
}
