import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime {
  String format([String format = 'yyyy-MM-dd']) => DateFormat(format).format(this);
}