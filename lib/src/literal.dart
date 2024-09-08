part of '../scanf.dart';

/// Literal scanner, skips matching characters of pattern

class Literal extends Scanner {
  /// Literal to skip
  final String text;

  /// Creates a literal scanner which tries to skip the characters of "text"
  const Literal({required this.text});

  @override
  bool scan(CharGet chars, List matches) {
    for (int i = 0; i < text.length; i++) {
      if (chars.ch != text.codeUnitAt(i)) {
        return false;
      }
      chars.getCh();
    }
    return true;
  }

  @override
  String toString() {
    return '${super.toString()}: text=$text';
  }
}
