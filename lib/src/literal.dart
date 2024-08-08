part of '../scanf.dart';

class Literal extends Scanner {
  final String text;

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
