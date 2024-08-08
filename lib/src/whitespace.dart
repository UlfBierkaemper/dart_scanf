part of '../scanf.dart';

class WhiteSpaceScanner extends Scanner {
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
