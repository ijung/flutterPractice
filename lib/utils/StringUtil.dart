import 'dart:core';


class StringUtil {
  static makeCommaedString (int value) {
    if (value == 0)
      return '0';

    final sign = (value >= 0)? '': '-';

    int abs_value = value.abs();

    final value_strs = <String>[];
    while (abs_value > 0) {
      final v = abs_value % 1000;
      abs_value = abs_value ~/ 1000;

      if (abs_value > 0)
        value_strs.add('$v'.padLeft(3, '0'));
      else
        value_strs.add('$v');
    }

    return sign + value_strs.reversed.join(',');
  }
}