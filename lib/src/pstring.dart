part of '../scanf.dart';

/// String scanner, used to scan %s

class StringScanner extends Percent {
  /// Creates a StringScanner which skips white spaces before scanning.
  const StringScanner({
    super.width,
    required super.ignore,
  });

  @override
  bool scan(CharGet chars, List matches) {
    final codeUnits = <int>[];
    int w = width;
    chars.skipWS();
    if (chars.ch > 0) {
      do {
        codeUnits.add(chars.ch);
        chars.getCh();
      } while (isVisible(chars.ch) && --w != 0);
      addMatch(matches, String.fromCharCodes(codeUnits));
      return true;
    }
    return false;
  }
}
