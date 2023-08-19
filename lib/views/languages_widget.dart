import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/theme_lang_notifier.dart';
import 'package:tandrustito/views/home.dart';

class LanguagesFlags extends StatelessWidget {
  const LanguagesFlags({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeLangNotifier>(builder: (context, myType, child) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlagWidget(
                  text: "کوردی",
                  lang: "ku",
                  selected: ThemeLangNotifier.instance.lang == "ku"),
              SizedBox(width: 10.h),
              FlagWidget(
                  text: "عربی",
                  lang: "ar",
                  selected: ThemeLangNotifier.instance.lang == "ar"),
              SizedBox(width: 10.h),
              FlagWidget(
                  text: "English",
                  lang: "en",
                  selected: ThemeLangNotifier.instance.lang == "en"),
            ],
          ),
        ),
      );
    });
  }
}

class FlagWidget extends StatelessWidget {
  const FlagWidget({
    Key? key,
    required this.selected,
    required this.lang,
    required this.text,
  }) : super(key: key);
  final bool selected;
  final String lang;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(360),
        onTap: () async {
          ThemeLangNotifier.instance.changeLang(lang);
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: selected ? primaryColor : Color.fromARGB(255, 8, 167, 114),
              borderRadius: BorderRadius.circular(90),
              border: Border.all(
                  color:
                      selected ? primaryColor : Color.fromARGB(255, 24, 38, 99),
                  width: 1)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 15.sp,
                  color: selected ? Colors.white : Colors.black,
                  height: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}
