part of '../scanf.dart';

/// Integer number scanner, used for %i.
/// Accepts hexadecimal values.

class IntScanner extends NumberScanner {
  /// Generative constructor, forwards to super
  IntScanner({
    super.width,
    required super.ignore,
  });

  @override
  bool scan(CharGet chars, List matches) {
    bool zero = false;
    int base = 10;
    chars.skipWS();
    final neg = negative(chars);
    if (chars.ch == codeDigit0) {
      zero = true;
      base = 8;
      chars.getCh();
      if (chars.ch == codeLowerCaseX || chars.ch == codeCapitalX) {
        base = 16;
        chars.getCh();
      }
    }
    final value = number(chars, base);
    if (value == null) {
      if (zero) {
        matches.add(0);
        return true;
      }
      return false;
    }
    matches.add(neg ? -value : value);
    return true;
  }
}
