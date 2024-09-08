part of '../scanf.dart';

/// Explicite hexadecimal scanner, used for %x or %X

class HexScanner extends NumberScanner {
  /// Generative constructor, forwards to super
  const HexScanner({
    super.width,
    required super.ignore,
  });

  @override
  bool scan(CharGet chars, List matches) {
    chars.skipWS();
    final neg = negative(chars);
    if (chars.ch == codeDigit0) {
      chars.getCh();
      if (chars.ch == codeLowerCaseX || chars.ch == codeCapitalX) {
        chars.getCh();
      }
    }
    final value = number(chars, 16);
    if (value == null) {
      return false;
    }
    matches.add(neg ? -value : value);
    return true;
  }
}
