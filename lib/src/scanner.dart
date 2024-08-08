part of '../scanf.dart';

abstract class Scanner {
  const Scanner();

  bool scan(CharGet chars, List matches);
}
