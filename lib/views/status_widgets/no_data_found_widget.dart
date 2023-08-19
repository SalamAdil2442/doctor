import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';

class NoDataFound extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final String text;
  const NoDataFound({Key? key, required this.onRefresh, required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextStyle boldTextStyle = TextStyle(
      fontSize: 20.sp,
      color: theme.textTheme.bodyLarge?.color,
    );
    return Center(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   Assets.images.emptyConceptIllustration1143601233.path,
                  //   height: 350.h,
                  // ),
                  // const SizedBox(height: 25),
                  Text(text, style: boldTextStyle),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
