import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_custom.dart' as date_symbol_data_custom;

class _CkbWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const _CkbWidgetsLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == "ku";
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) async {
    // const String localeName = "kur_ckb";
    // await intl.initializeDateFormatting(localeName, null);
    return SynchronousFuture<WidgetsLocalizations>(
      CkbWidgetLocalizations(),
    );
  }

  @override
  bool shouldReload(_CkbWidgetsLocalizationsDelegate old) => true;
}

class CkbWidgetLocalizations extends WidgetsLocalizations {
  static const LocalizationsDelegate<WidgetsLocalizations> delegate =
      _CkbWidgetsLocalizationsDelegate();
  @override
  TextDirection get textDirection => TextDirection.rtl;

  @override
  // TODO: implement reorderItemDown
  String get reorderItemDown => "";

  @override
  // TODO: implement reorderItemLeft
  String get reorderItemLeft => "";

  @override
  // TODO: implement reorderItemRight
  String get reorderItemRight => "";

  @override
  // TODO: implement reorderItemToEnd
  String get reorderItemToEnd => "";

  @override
  // TODO: implement reorderItemToStart
  String get reorderItemToStart => "";

  @override
  // TODO: implement reorderItemUp
  String get reorderItemUp => "";
}

class _CkbMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _CkbMaterialLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == "ku";
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    const String localeName = "ku";
    date_symbol_data_custom.initializeDateFormattingCustom(
      locale: localeName,
      patterns: ckbLocaleDatePatterns,
      symbols: DateSymbols.deserializeFromMap(ckbDateSymbols),
    );
    return SynchronousFuture<MaterialLocalizations>(
      CkbMaterialLocalizations(
        localeName: "ku",
        fullYearFormat: intl.DateFormat('y', localeName),
        shortDateFormat: intl.DateFormat('MM/DD/YY', localeName),
        compactDateFormat: intl.DateFormat('EEE, MMM d', localeName),
        shortMonthDayFormat: intl.DateFormat('MM/DD', localeName),
        mediumDateFormat: intl.DateFormat('EEE, MMM d', localeName),
        longDateFormat: intl.DateFormat('EEEE, MMMM d, y', localeName),
        yearMonthFormat: intl.DateFormat('MMMM y', localeName),
        // The `intl` library's NumberFormat class is generated from CLDR data
        // (see https://github.com/dart-lang/intl/blob/master/lib/number_symbols_data.dart).
        // Unfortunately, there is no way to use a locale that isn't defined in
        // this map and the only way to work around this is to use a listed
        // locale's NumberFormat symbols. So, here we use the number formats
        // for 'ar' instead.
        decimalFormat: intl.NumberFormat('#,##0.###', 'ar'),
        twoDigitZeroPaddedFormat: intl.NumberFormat('00', 'ar'),
      ),
    );
  }

  @override
  bool shouldReload(_CkbMaterialLocalizationsDelegate old) => false;
}

class CkbMaterialLocalizations extends GlobalMaterialLocalizations {
  const CkbMaterialLocalizations({
    String localeName = "ku",
    required intl.DateFormat fullYearFormat,
    required intl.DateFormat shortDateFormat,
    required intl.DateFormat compactDateFormat,
    required intl.DateFormat shortMonthDayFormat,
    required intl.DateFormat mediumDateFormat,
    required intl.DateFormat longDateFormat,
    required intl.DateFormat yearMonthFormat,
    required intl.NumberFormat decimalFormat,
    required intl.NumberFormat twoDigitZeroPaddedFormat,
  }) : super(
            localeName: localeName,
            shortDateFormat: shortDateFormat,
            compactDateFormat: compactDateFormat,
            shortMonthDayFormat: shortMonthDayFormat,
            fullYearFormat: fullYearFormat,
            mediumDateFormat: mediumDateFormat,
            longDateFormat: longDateFormat,
            yearMonthFormat: yearMonthFormat,
            decimalFormat: decimalFormat,
            twoDigitZeroPaddedFormat: twoDigitZeroPaddedFormat);
  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      _CkbMaterialLocalizationsDelegate();
  @override
  String get aboutListTileTitleRaw => 'دەربارەی \$applicationName';
  @override
  String get alertDialogLabel => 'ئاگادارکردنەوە';
  @override
  String get anteMeridiemAbbreviation => 'پ.ن';
  @override
  String get backButtonTooltip => 'دواوە';
  @override
  String get calendarModeButtonLabel => 'گۆڕین بۆ ڕۆژژمێر';
  @override
  String get cancelButtonLabel => 'هەڵوەشاندنەوه';
  @override
  String get closeButtonLabel => 'داخستن';
  @override
  String get closeButtonTooltip => 'داخستن';
  @override
  String get collapsedIconTapHint => 'فراوانکردن';
  @override
  String get continueButtonLabel => 'بەردەوام بە';
  @override
  String get copyButtonLabel => 'کۆپی';
  @override
  String get cutButtonLabel => 'بڕین';
  @override
  String get dateHelpText => 'mm/dd/yyyy';
  @override
  String get dateInputLabel => 'بەروار بنووسە';
  @override
  String get dateOutOfRangeLabel => 'دەرەوەی مەودایە';
  @override
  String get datePickerHelpText => 'بەروار دیاری بکە';
  @override
  String get dateRangeEndDateSemanticLabelRaw => 'بەرواری کۆتایی \$fullDate';
  @override
  String get dateRangeEndLabel => 'بەرواری کۆتایی';
  @override
  String get dateRangePickerHelpText => 'دەست نیشانکردنی مەودا';
  @override
  String get dateRangeStartDateSemanticLabelRaw =>
      'بەرواری دەستپێکردن \$fullDate';
  @override
  String get dateRangeStartLabel => 'بەرواری دەستپێکردن';
  @override
  String get dateSeparator => '/';
  @override
  String get deleteButtonTooltip => 'سڕینەوە';
  @override
  String get dialModeButtonLabel => 'گۆڕین بۆ دۆخی هەڵبژێری داواکردن';
  @override
  String get dialogLabel => 'دیالۆگ';
  @override
  String get drawerLabel => 'لیستی ڕێنیشاندەر';
  @override
  String get expandedIconTapHint => 'نوشتانەوە';
  @override
  String get hideAccountsLabel => 'شاردنەوەی ئەژمێرەکان';
  @override
  String get inputDateModeButtonLabel => 'گۆڕین بۆ نووسین';
  @override
  String get inputTimeModeButtonLabel => 'گۆڕین بۆ دۆخی تێکردنی دەق';
  @override
  String get invalidDateFormatLabel => 'فۆرماتی نادروست.';
  @override
  String get invalidDateRangeLabel => 'مەودایەکی نادروست.';
  @override
  String get invalidTimeLabel => 'کاتێکی دروست بنووسە';
  @override
  String get licensesPackageDetailTextOne => '١ مۆڵەت';
  @override
  String get licensesPackageDetailTextOther => '\$licenseCount مۆڵەت';
  @override
  String get licensesPackageDetailTextZero => 'مۆڵەت نیە';
  @override
  String get licensesPageTitle => 'مۆڵەتەکان';
  @override
  String get modalBarrierDismissLabel => 'دەرکردن';
  @override
  String get moreButtonTooltip => 'زیاتر';
  @override
  String get nextMonthTooltip => 'مانگی داهاتوو';
  @override
  String get nextPageTooltip => 'لاپەڕەی داهاتوو';
  @override
  String get okButtonLabel => 'باشه';
  @override
  String get openAppDrawerTooltip => 'کردنەوەی لیستی ڕێنیشاندەر';
  @override
  String get pageRowsInfoTitleRaw => '\$firstRow–\$lastRow لە \$rowCount';
  @override
  String get pageRowsInfoTitleApproximateRaw =>
      '\$firstRow–\$lastRow تا \$rowCount';
  @override
  String get pasteButtonLabel => 'پەیست';
  @override
  String get popupMenuLabel => 'لیستی دەرکەوتە';
  @override
  String get postMeridiemAbbreviation => 'د.ن';
  @override
  String get previousMonthTooltip => 'مانگی پێشوو';
  @override
  String get previousPageTooltip => 'لاپەڕەی پێشوو';
  @override
  String get refreshIndicatorSemanticLabel => 'نوێکردنەوە';
  @override
  String get remainingTextFieldCharacterCountFew => "";
  @override
  List<String> get narrowWeekdays => ['ی', 'د', 'س', 'چ', 'پ', 'ه', 'ش'];
  @override
  String get remainingTextFieldCharacterCountMany => "";
  @override
  String get remainingTextFieldCharacterCountOne => '١ پیت ماوە';
  @override
  String get remainingTextFieldCharacterCountOther =>
      '\$remainingCount پیتەکان ماون';
  @override
  String get remainingTextFieldCharacterCountTwo => "";
  @override
  String get remainingTextFieldCharacterCountZero => 'هیچ پیتێک نەماوەتەوە';
  @override
  String get reorderItemDown => 'بڕۆ خوارەوە';
  @override
  String get reorderItemLeft => 'بڕۆ لای چەپ';
  @override
  String get reorderItemRight => 'بڕۆ لای راست';
  @override
  String get reorderItemToEnd => 'بڕۆ کۆتایی';
  @override
  String get reorderItemToStart => 'بڕۆ سەرەتا';
  @override
  String get reorderItemUp => 'بڕۆ سەرەوە';
  @override
  String get rowsPerPageTitle => 'ڕیزەکان بۆ هەر پەڕەیەک:';
  @override
  String get saveButtonLabel => 'هەڵگرتن';
  @override
  ScriptCategory get scriptCategory => ScriptCategory.tall;
  @override
  String get searchFieldLabel => 'گەڕان';
  @override
  String get selectAllButtonLabel => 'هەموو هەڵبژێرە';
  @override
  String get selectYearSemanticsLabel => 'ساڵ هەڵبژێرە';
  @override
  String get selectedRowCountTitleFew => "";
  @override
  String get selectedRowCountTitleMany => "";
  @override
  String get selectedRowCountTitleOne => '١ دانە هەڵبژێردرا';
  @override
  String get selectedRowCountTitleOther => '\$selectedRowCount هەڵبژێردراو';
  @override
  String get selectedRowCountTitleTwo => "";
  @override
  String get selectedRowCountTitleZero => 'هیچ هەڵنەبژێراوە';
  @override
  String get showAccountsLabel => 'پیشاندانی ئەژمێرەکان';
  @override
  String get showMenuTooltip => 'پیشاندانی پێڕست';
  @override
  String get signedInLabel => 'چوونە ژوورەوە';
  @override
  String get tabLabelRaw => 'خشتەبەندی \$tabIndex لە \$tabCount';
  @override
  TimeOfDayFormat get timeOfDayFormatRaw => TimeOfDayFormat.h_colon_mm_space_a;
  @override
  String get timePickerDialHelpText => 'کات هەڵبژێرە';
  @override
  String get timePickerHourLabel => 'کاتژمێر';
  @override
  String get timePickerHourModeAnnouncement => 'کاتژمێر هەڵبژێرە';
  @override
  String get timePickerInputHelpText => 'کات بنووسە';
  @override
  String get timePickerMinuteLabel => 'خولەک';
  @override
  String get timePickerMinuteModeAnnouncement => 'خولەک هەڵبژێرە';
  @override
  String get unspecifiedDate => 'بەروار';
  @override
  String get unspecifiedDateRange => 'مەودای بەروار';
  @override
  String get viewLicensesButtonLabel => 'پیشاندانی مۆڵەتەکان';
  @override
  String get firstPageTooltip => 'لاپه‌ڕه‌ی سه‌ره‌تا';
  @override
  String get lastPageTooltip => 'دوایین لاپه‌ڕه‌';
  @override
  String get keyboardKeyAlt => "";
  @override
  String get keyboardKeyAltGraph => "";
  @override
  String get keyboardKeyBackspace => "";
  @override
  String get keyboardKeyCapsLock => "";
  @override
  String get keyboardKeyChannelDown => "";
  @override
  String get keyboardKeyChannelUp => "";
  @override
  String get keyboardKeyControl => "";
  @override
  String get keyboardKeyDelete => "";

  @override
  String get keyboardKeyEject => "";
  @override
  String get keyboardKeyEnd => "";
  @override
  String get keyboardKeyEscape => "";
  @override
  String get keyboardKeyFn => "";

  @override
  String get keyboardKeyHome => "";
  @override
  String get keyboardKeyInsert => "";

  @override
  String get keyboardKeyMeta => "";
  @override
  String get keyboardKeyMetaMacOs => "";
  @override
  String get keyboardKeyMetaWindows => "";
  @override
  String get keyboardKeyNumLock => "";
  @override
  String get keyboardKeyNumpad0 => "";
  @override
  String get keyboardKeyNumpad1 => "";
  @override
  String get keyboardKeyNumpad2 => "";
  @override
  String get keyboardKeyNumpad3 => "";
  @override
  String get keyboardKeyNumpad4 => "";
  @override
  String get keyboardKeyNumpad5 => "";
  @override
  String get keyboardKeyNumpad6 => "";
  @override
  String get keyboardKeyNumpad7 => "";
  @override
  String get keyboardKeyNumpad8 => "";
  @override
  String get keyboardKeyNumpad9 => "";
  @override
  String get keyboardKeyNumpadAdd => "";
  @override
  String get keyboardKeyNumpadComma => "";
  @override
  String get keyboardKeyNumpadDecimal => "";
  @override
  String get keyboardKeyNumpadDivide => "";
  @override
  String get keyboardKeyNumpadEnter => "";
  @override
  String get keyboardKeyNumpadEqual => "";
  @override
  String get keyboardKeyNumpadMultiply => "";
  @override
  String get keyboardKeyNumpadParenLeft => "";
  @override
  String get keyboardKeyNumpadParenRight => "";
  @override
  String get keyboardKeyNumpadSubtract => "";
  @override
  String get keyboardKeyPageDown => "";
  @override
  String get keyboardKeyPageUp => "";
  @override
  String get keyboardKeyPower => "";
  @override
  String get keyboardKeyPowerOff => "";
  @override
  String get keyboardKeyPrintScreen => "";

  @override
  String get keyboardKeyScrollLock => "";
  @override
  String get keyboardKeySelect => "";
  @override
  String get keyboardKeySpace => "";

  @override
  String get menuBarMenuLabel => "";

  @override
  // TODO: implement bottomSheetLabel
  String get bottomSheetLabel => "";

  @override
  // TODO: implement currentDateLabel
  String get currentDateLabel => "";

  @override
  // TODO: implement keyboardKeyShift
  String get keyboardKeyShift => "";

  @override
  // TODO: implement scrimLabel
  String get scrimLabel => "";

  @override
  // TODO: implement scrimOnTapHintRaw
  String get scrimOnTapHintRaw => "hint";
}

const ckbDateSymbols = {
  'NAME': "ku",
  'ERAS': ['پ.ز', 'ز'],
  'ERANAMES': ['پێش زاینی', 'زاینی'],
  'NARROWMONTHS': [
    'ک.د',
    'ش',
    'ز',
    'ن',
    'م',
    'ح',
    'ت',
    'ئ',
    'ل',
    'ت.ی',
    'ت.د',
    'ک.ی'
  ],
  'STANDALONENARROWMONTHS': [
    'ک.د',
    'ش',
    'ز',
    'ن',
    'م',
    'ح',
    'ت',
    'ئ',
    'ل',
    'ت.ی',
    'ت.د',
    'ک.ی'
  ],
  'MONTHS': [
    'کانونی دووەم',
    'شوبات',
    'ئازار',
    'نیسان',
    'مایس',
    'حوزەیران',
    'تەمموز',
    'ئاب',
    'ئەیلوول',
    'تشرینی یەکەم',
    'تشرینی دووەم',
    'کانونی یەکەم',
  ],
  'STANDALONEMONTHS': [
    'کانونی دووەم',
    'شوبات',
    'ئازار',
    'نیسان',
    'مایس',
    'حوزەیران',
    'تەمموز',
    'ئاب',
    'ئەیلوول',
    'تشرینی یەکەم',
    'تشرینی دووەم',
    'کانونی یەکەم',
  ],
  'SHORTMONTHS': [
    'کانونی دووەم',
    'شوبات',
    'ئازار',
    'نیسان',
    'مایس',
    'حوزەیران',
    'تەمموز',
    'ئاب',
    'ئەیلوول',
    'تشرینی یەکەم',
    'تشرینی دووەم',
    'کانونی یەکەم',
  ],
  'STANDALONESHORTMONTHS': [
    'کانونی دووەم',
    'شوبات',
    'ئازار',
    'نیسان',
    'مایس',
    'حوزەیران',
    'تەمموز',
    'ئاب',
    'ئەیلوول',
    'تشرینی یەکەم',
    'تشرینی دووەم',
    'کانونی یەکەم',
  ],
  'WEEKDAYS': [
    'یەکشەممە',
    'دووشەممە',
    'سێشەممە',
    'چوارشەممە',
    'پێنجشەممە',
    'هەینی',
    'شەممە'
  ],
  'STANDALONEWEEKDAYS': [
    'یەکشەممە',
    'دووشەممە',
    'سێشەممە',
    'چوارشەممە',
    'پێنجشەممە',
    'هەینی',
    'شەممە'
  ],
  'SHORTWEEKDAYS': [
    'یەکشەم',
    'دووشەم',
    'سێشەم',
    'چوارشەم',
    'پێنجشەم',
    'هەینی',
    'شەممە'
  ],
  'STANDALONESHORTWEEKDAYS': [
    'یەکشەم',
    'دووشەم',
    'سێشەم',
    'چوارشەم',
    'پێنجشەم',
    'هەینی',
    'شەممە'
  ],
  'NARROWWEEKDAYS': ['ی', 'د', 'س', 'چ', 'پ', 'ه', 'ش'],
  'STANDALONENARROWWEEKDAYS': ['ی', 'د', 'س', 'چ', 'پ', 'ه', 'ش'],
  'SHORTQUARTERS': ['چ١', 'چ٢', 'چ٣', 'چ٤'],
  'QUARTERS': ['چارەکی یەکەم', 'چارەکی دووەم', 'چارەکی سێیەم', 'چارەکی چوارەم'],
  'AMPMS': ['پ.ن', 'د.ن'],
  'DATEFORMATS': [
    'EEEE، d MMMM y',
    'd MMMM y',
    'dd‏/MM‏/y',
    'd‏/M‏/y',
  ],
  'TIMEFORMATS': [
    'h:mm:ss a zzzz',
    'h:mm:ss a z',
    'h:mm:ss a',
    'h:mm a',
  ],
  'AVAILABLEFORMATS': null,
  'DATETIMEFORMATS': [
    '{1} {0}',
    '{1} {0}',
    '{1} {0}',
    '{1} {0}',
  ],
  'ZERODIGIT': '٠',
  'FIRSTDAYOFWEEK': 5,
  'WEEKENDRANGE': [4, 5],
  'FIRSTWEEKCUTOFFDAY': 3
};
const ckbLocaleDatePatterns = {
  'd': 'd', // DAY
  'E': 'ccc', // ABBR_WEEKDAY
  'EEEE': 'cccc', // WEEKDAY
  'LLL': 'LLL', // ABBR_STANDALONE_MONTH
  'LLLL': 'LLLL', // STANDALONE_MONTH
  'M': 'L', // NUM_MONTH
  'Md': 'd/‏M', // NUM_MONTH_DAY
  'MEd': 'EEE، d/M', // NUM_MONTH_WEEKDAY_DAY
  'MMM': 'LLL', // ABBR_MONTH
  'MMMd': 'd MMM', // ABBR_MONTH_DAY
  'MMMEd': 'EEE، d MMM', // ABBR_MONTH_WEEKDAY_DAY
  'MMMM': 'LLLL', // MONTH
  'MMMMd': 'd MMMM', // MONTH_DAY
  'MMMMEEEEd': 'EEEE، d MMMM', // MONTH_WEEKDAY_DAY
  'QQQ': 'QQQ', // ABBR_QUARTER
  'QQQQ': 'QQQQ', // QUARTER
  'y': 'y', // YEAR
  'yM': 'M‏/y', // YEAR_NUM_MONTH
  'yMd': 'd‏/M‏/y', // YEAR_NUM_MONTH_DAY
  'yMEd': 'EEE، d/‏M/‏y', // YEAR_NUM_MONTH_WEEKDAY_DAY
  'yMMM': 'MMM y', // YEAR_ABBR_MONTH
  'yMMMd': 'd MMM y', // YEAR_ABBR_MONTH_DAY
  'yMMMEd': 'EEE، d MMM y', // YEAR_ABBR_MONTH_WEEKDAY_DAY
  'yMMMM': 'MMMM y', // YEAR_MONTH
  'yMMMMd': 'd MMMM y', // YEAR_MONTH_DAY
  'yMMMMEEEEd': 'EEEE، d MMMM y', // YEAR_MONTH_WEEKDAY_DAY
  'yQQQ': 'QQQ y', // YEAR_ABBR_QUARTER
  'yQQQQ': 'QQQQ y', // YEAR_QUARTER
  'H': 'HH', // HOUR24
  'Hm': 'HH:mm', // HOUR24_MINUTE
  'Hms': 'HH:mm:ss', // HOUR24_MINUTE_SECOND
  'j': 'h a', // HOUR
  'jm': 'h:mm a', // HOUR_MINUTE
  'jms': 'h:mm:ss a', // HOUR_MINUTE_SECOND
  'jmv': 'h:mm a v', // HOUR_MINUTE_GENERIC_TZ
  'jmz': 'h:mm a z', // HOUR_MINUTETZ
  'jz': 'h a z', // HOURGENERIC_TZ
  'm': 'm', // MINUTE
  'ms': 'mm:ss', // MINUTE_SECOND
  's': 's', // SECOND
  'v': 'v', // ABBR_GENERIC_TZ
  'z': 'z', // ABBR_SPECIFIC_TZ
  'zzzz': 'zzzz', // SPECIFIC_TZ
  'ZZZZ': 'ZZZZ' // ABBR_UTC_TZ
};

class CupertinoLocalizationKu extends GlobalCupertinoLocalizations {
  /// Create an instance of the translation bundle for Arabic.
  ///
  /// For details on the meaning of the arguments, see [GlobalCupertinoLocalizations].
  const CupertinoLocalizationKu({
    String localeName = "ku",
    required intl.DateFormat fullYearFormat,
    required intl.DateFormat dayFormat,
    required intl.DateFormat mediumDateFormat,
    required intl.DateFormat singleDigitHourFormat,
    required intl.DateFormat singleDigitMinuteFormat,
    required intl.DateFormat doubleDigitMinuteFormat,
    required intl.DateFormat singleDigitSecondFormat,
    required intl.NumberFormat decimalFormat,
  }) : super(
          localeName: localeName,
          fullYearFormat: fullYearFormat,
          dayFormat: dayFormat,
          mediumDateFormat: mediumDateFormat,
          singleDigitHourFormat: singleDigitHourFormat,
          singleDigitMinuteFormat: singleDigitMinuteFormat,
          doubleDigitMinuteFormat: doubleDigitMinuteFormat,
          singleDigitSecondFormat: singleDigitSecondFormat,
          decimalFormat: decimalFormat,
        );
  @override
  String get alertDialogLabel => 'تنبيه';
  @override
  String get anteMeridiemAbbreviation => 'ص';
  @override
  String get copyButtonLabel => 'نسخ';
  @override
  String get cutButtonLabel => 'قص';
  @override
  String get datePickerDateOrderString => 'dmy';
  @override
  String get datePickerDateTimeOrderString => 'date_time_dayPeriod';
  @override
  String? get datePickerHourSemanticsLabelFew => r'$hour بالضبط';
  @override
  String? get datePickerHourSemanticsLabelMany => r'$hour بالضبط';
  @override
  String? get datePickerHourSemanticsLabelOne => r'$hour بالضبط';
  @override
  String get datePickerHourSemanticsLabelOther => r'$hour بالضبط';
  @override
  String? get datePickerHourSemanticsLabelTwo => r'$hour بالضبط';
  @override
  String? get datePickerHourSemanticsLabelZero => r'$hour بالضبط';
  @override
  String? get datePickerMinuteSemanticsLabelFew => r'$minute دقائق';
  @override
  String? get datePickerMinuteSemanticsLabelMany => r'$minute دقيقة​';
  @override
  String? get datePickerMinuteSemanticsLabelOne => 'دقيقة واحدة';
  @override
  String get datePickerMinuteSemanticsLabelOther => r'$minute دقيقة​';
  @override
  String? get datePickerMinuteSemanticsLabelTwo => r'دقيقتان ($minute)';
  @override
  String? get datePickerMinuteSemanticsLabelZero => r'$minute دقيقة​';
  @override
  String get modalBarrierDismissLabel => 'رفض';
  @override
  String get pasteButtonLabel => 'لصق';
  @override
  String get postMeridiemAbbreviation => 'م';
  @override
  String get searchTextFieldPlaceholderLabel => 'بحث';
  @override
  String get selectAllButtonLabel => 'اختيار الكل';
  @override
  String get tabSemanticsLabelRaw => r'علامة التبويب $tabIndex من $tabCount';
  @override
  String? get timerPickerHourLabelFew => 'ساعات';
  @override
  String? get timerPickerHourLabelMany => 'ساعة';
  @override
  String? get timerPickerHourLabelOne => 'ساعة';
  @override
  String get timerPickerHourLabelOther => 'ساعة';
  @override
  String? get timerPickerHourLabelTwo => 'ساعتان';
  @override
  String? get timerPickerHourLabelZero => 'ساعة';
  @override
  String? get timerPickerMinuteLabelFew => 'دقائق';
  @override
  String? get timerPickerMinuteLabelMany => 'دقيقة';
  @override
  String? get timerPickerMinuteLabelOne => 'دقيقة واحدة';
  @override
  String get timerPickerMinuteLabelOther => 'دقيقة';
  @override
  String? get timerPickerMinuteLabelTwo => 'دقيقتان';
  @override
  String? get timerPickerMinuteLabelZero => 'دقيقة';
  @override
  String? get timerPickerSecondLabelFew => 'ثوانٍ';
  @override
  String? get timerPickerSecondLabelMany => 'ثانية';
  @override
  String? get timerPickerSecondLabelOne => 'ثانية واحدة';
  @override
  String get timerPickerSecondLabelOther => 'ثانية';
  @override
  String? get timerPickerSecondLabelTwo => 'ثانيتان';
  @override
  String? get timerPickerSecondLabelZero => 'ثانية';
  @override
  String get todayLabel => 'اليوم';

  @override
  // TODO: implement noSpellCheckReplacementsLabel
  String get noSpellCheckReplacementsLabel => "";
}
