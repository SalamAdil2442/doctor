import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/localization/translate_keys.dart';

class NetWorkErrorWidget extends StatelessWidget {
  final Future<void> Function() onPress;
  final String text;
  const NetWorkErrorWidget(
      {Key? key, required this.onPress, required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextStyle boldTextStyle = TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: (20.sp),
    );
    return RefreshIndicator(
      onRefresh: onPress,
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - (200),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(Assets.images.noInternetConnectionEmptyState.path,
                //     height: 300.h),
                // const SizedBox(height: 25),
                Text(text, textAlign: TextAlign.center, style: boldTextStyle),
                const SizedBox(height: 14),
                TextButton(
                  onPressed: () {
                    onPress();
                  },
                  child: Text(Trans.retry.trans(),
                      textAlign: TextAlign.center, style: boldTextStyle),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
