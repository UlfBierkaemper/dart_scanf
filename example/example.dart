import 'package:scanf/scanf.dart';

void main() {
  final scanf = ScanF('Real: %e, Value: %e, Float: %f, Int=%i, Octal=%o %[^:]:%f%%, %[a-c]%s');
  final result = scanf.match('Real: -3.14E+2, Value: -3.14E-2, Float: 3.14, Int=0xCAFEBABE, Octal=755 Progress:34.2%, abcdef');
  print(scanf);
  print('$result');
}
