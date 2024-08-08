part of '../scanf.dart';

abstract class NumberScanner extends Percent {
  const NumberScanner({
    super.width,
    required super.ignore,
  });

  bool negative(CharGet chars) {
    switch (chars.ch) {
      case codeMinus:
        chars.getCh();
        return true;

      case codePlus:
        chars.getCh();
        return false;

      default:
        return false;
    }
  }

  int? number(CharGet chars, int base) {
    int digit = nextDigit(chars, base);
    if (digit < 0) {
      return null;
    }
    int w = width;
    int result = 0;
    do {
      result = result * base + digit;
      digit = nextDigit(chars, base);
    } while (digit >= 0 && --w != 0);
    return result;
  }
}
