part of '../scanf.dart';

/// Explicite octal number scanner, used for %o

class OctalScanner extends NumberScanner {
  /// Generative constructor, forwards to super
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
