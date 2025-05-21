import 'package:intl/intl.dart';

extension NumberFormatting on num {
  String toFormattedString() => NumberFormat("#,##0.00").format(this);
}
