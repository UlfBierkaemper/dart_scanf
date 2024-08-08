part of '../scanf.dart';

class SetScanner extends Percent {
  final Set<int> scanset;
  final bool reject;

  const SetScanner({
    required this.scanset,
    this.reject = false,
    super.width,
    required super.ignore,
  });

  @override
  bool scan(CharGet chars, List matches) {
    bool valid(int ch) => scanset.contains(ch) ^ reject;

    final codeUnits = <int>[];
    int w = width;
    if (valid(chars.ch)) {
      do {
        codeUnits.add(chars.ch);
        chars.getCh();
      } while (valid(chars.ch) && --w != 0);
      addMatch(matches, String.fromCharCodes(codeUnits));
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return '${super.toString()}, scanset=$scanset, reject=$reject';
  }
}
