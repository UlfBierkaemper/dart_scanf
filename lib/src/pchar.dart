part of '../scanf.dart';

class CharScanner extends Percent {
  const CharScanner({
    super.width,
    required super.ignore,
  });

  @override
  bool scan(CharGet chars, List matches) {
    final codeUnits = <int>[];
    int w = width < 0 ? 1 : width;
    if (chars.ch > 0) {
      do {
        codeUnits.add(chars.ch);
        chars.getCh();
      } while (chars.ch > 0 && --w != 0);
      addMatch(matches, String.fromCharCodes(codeUnits));
      return true;
    }
    return false;
  }
}
