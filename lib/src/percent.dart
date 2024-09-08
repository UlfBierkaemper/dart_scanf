part of '../scanf.dart';

/// The base class for all percent-driven scanners

abstract class Percent extends Scanner {
  /// The maximum amount of characters to scan
  final int width;

  /// Should be ignored in resulting matches
  final bool ignore;

  /// Generative constructor
  const Percent({
    this.width = -1,
    required this.ignore,
  });

  /// Adds a match to the list of matches.
  /// The type of match ("value") depends on the respective scanner.
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
