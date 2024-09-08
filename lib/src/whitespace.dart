part of '../scanf.dart';

/// Simple white space scanner, used to skip white spaces

class WhiteSpaceScanner extends Scanner {
  /// Generative constructor
  const WhiteSpaceScanner();

  @override
  bool scan(CharGet chars, List matches) {
    while (isWS(chars.ch)) {
      chars.getCh();
    }
    return true;
  }

  @override
  String toString() {
    return '$runtimeType';
  }
}
