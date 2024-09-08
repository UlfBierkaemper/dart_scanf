part of '../scanf.dart';

/// Base class for all number scanners

abstract class NumberScanner extends Percent {
  /// Creates a number scanner with the given maximum amount of digits
  const NumberScanner({
    super.width,
    required super.ignore,
  });

  /// Scans the sign of the value. Returns "true" if negative.
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

  /// Scans a number and returns its value or "null" if no number is scanned.
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
