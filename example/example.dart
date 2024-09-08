import 'package:scanf/scanf.dart';

void main() {
  final scanf = ScanF('Pi: %f, Int=%i, Octal=%o %[^:]:%f%%, %[a-c]%s');
  final result = scanf.match('Pi: 3.14, Int=0xCAFEBABE, Octal=755 Progress:34.2%, abcdef');
  print('$result');
}
