import 'package:easy_localization/easy_localization.dart';

import '../../data/constants/global_obj.dart';

class AppDateFormatter {
  static String get _locale =>
      EasyLocalization.of(navigatorKey.currentContext!)!.locale.languageCode;

  /// Format: 5 Aug 2025
  static String formatShortDate(DateTime date) {
    return DateFormat('d MMM yyyy', _locale).format(date);
  }

  /// Format: 05/08/2025
  static String formatNumericDate(DateTime date) {
    return DateFormat('dd/MM/yyyy', _locale).format(date);
  }

  /// Format: Tuesday, Aug 5, 2025
  static String formatFullDate(DateTime date) {
    return DateFormat('EEEE, MMM d, yyyy', _locale).format(date);
  }

  /// Format: 28-12-2023
  static String formatDashedDate(DateTime date) {
    return DateFormat('dd-MM-yyyy', _locale).format(date);
  }

  /// Custom format
  static String formatCustom(DateTime date, String pattern) {
    return DateFormat(pattern, _locale).format(date);
  }
}
