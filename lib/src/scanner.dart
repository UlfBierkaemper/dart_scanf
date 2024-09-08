part of '../scanf.dart';

/// Base class for all scanners

abstract class Scanner {
  /// Generative constructor
  const Scanner();

  /// Scans characters and adds matches to "matches".
  /// Returns true if a match is found.
  bool scan(CharGet chars, List matches);
}
