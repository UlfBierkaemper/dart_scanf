part of '../scanf.dart';

class OctalScanner extends NumberScanner {
  const OctalScanner({
    super.width,
    required super.ignore,
  });

  @override
  bool scan(CharGet chars, List matches) {
    chars.skipWS();
    final neg = negative(chars);
    final value = number(chars, 8);
    if (value == null) {
      return false;
    }
    matches.add(neg ? -value : value);
    return true;
  }
}
