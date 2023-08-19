import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';

class FaliedLoadPageWIdget extends StatelessWidget {
  final Future<void> Function() onPress;
  final String text;
  const FaliedLoadPageWIdget({
    Key? key,
    required this.onPress,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextStyle boldTextStyle = TextStyle(
        color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 20.sp);

    return Center(
      child: RefreshIndicator(
        onRefresh: onPress,
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - (200),
              width: Responsive.instance.scaleWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   Assets.images.error.path,
                  //   height: 300.h,
                  //   width: 300.h,
                  // ),
                  SizedBox(height: 35.h),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: boldTextStyle,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
