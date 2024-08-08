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

A "scanf"-like implementation in pure dart. For maximum speed, the pattern is
"compiled" into a list of scanners, which can perform very fast.

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

Being an old-fashioned C programmer, I have been using "scanf"-like functions all my life.

When I got into *Dart/Flutter*, I started to love this language and concepts more and more.
But regular expressions *(RegEx)* are still unlearnable for people like me,
so I looked around for a scanf-like implementation in *Dart*.

Surprisingly, I couldn't find anything. When I started a small project with *rsync*, the need for a
"stdout" parser arose.

With this package I was able to process the output of *rsync* without any problems, crateing a usable progress display.
