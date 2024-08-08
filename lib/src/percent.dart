part of '../scanf.dart';

abstract class Percent extends Scanner {
  final int width;
  final bool ignore;

  const Percent({
    this.width = -1,
    required this.ignore,
  });

  void addMatch(List matches, Object value) {
    if (ignore) {
      return;
    }
    matches.add(value);
  }

  @override
  String toString() {
    return '${super.toString()}: width=$width, ignore=$ignore';
  }
}
