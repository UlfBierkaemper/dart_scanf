<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

[![Pub Package](https://img.shields.io/pub/v/scanf.svg)](https://pub.dev/packages/scanf)
[![GitHub Issues](https://img.shields.io/github/issues/UlfBierkaemper/dart_scanf.svg)](https://github.com/UlfBierkaemper/dart_scanf/issues)
[![GitHub Forks](https://img.shields.io/github/forks/UlfBierkaemper/dart_scanf.svg)](https://github.com/UlfBierkaemper/dart_scanf/network)
[![GitHub Stars](https://img.shields.io/github/stars/UlfBierkaemper/dart_scanf.svg)](https://github.com/UlfBierkaemper/dart_scanf/stargazers)
[![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/UlfBierkaemper/dart_scanf/main/LICENSE)
[![Build Status](https://github.com/UlfBierkaemper/dart_scanf/actions/workflows/dart.yml/badge.svg?branch=main)](https://github.com/UlfBierkaemper/dart_scanf/actions)
[![Code Coverage](https://codecov.io/gh/UlfBierkaemper/dart_scanf/branch/main/graph/badge.svg?token=2yW74MVgun)](https://codecov.io/gh/UlfBierkaemper/dart_scanf)

A *scanf*-like implementation in pure *Dart*. For maximum speed, the pattern is
compiled into a list of scanners, which can perform very fast.

## Features

A very short example, how to use this package:

```Dart
import 'package:scanf/scanf.dart';

void main() {
  final scanf = ScanF('Pi: %f, Int=%i, Octal=%o %[^:]:%f%%, %[a-c]%s');
  final result = scanf.match('Pi: 3.14, Int=0xCAFEBABE, Octal=755 Progress:34.2%, abcdef');
  print('$result');
}
```

## Notes

Being an old-fashioned C programmer, I have been using *scanf*-like functions all my life.

When I got into *Dart/Flutter*, I started to love this language and concepts more and more.
But regular expressions *(RegEx)* are still unlearnable for people like me,
so I looked around for a *scanf*-like implementation in *Dart*.

Surprisingly, I couldn't find anything. When I started a small project with *rsync*, the need for a
"stdout" parser arose.

With this package I was able to process the output of *rsync* without any problems, crating a usable progress display.
