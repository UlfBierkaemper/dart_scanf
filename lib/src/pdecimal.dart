part of '../scanf.dart';

/// Number scanner, used to scan %d and %u

class DecimalScanner extends NumberScanner {
  /// Creates a decimal number scanner
  const DecimalScanner({
    super.width,
    required super.ignore,
  });

  @override
  bool scan(CharGet chars, List matches) {
    chars.skipWS();
    final neg = negative(chars);
    final value = number(chars, 10);
    if (value == null) {
      return false;
    }
    matches.add(neg ? -value : value);
    return true;
  }
}
