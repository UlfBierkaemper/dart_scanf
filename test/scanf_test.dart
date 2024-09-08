import 'package:scanf/scanf.dart';
import 'package:test/test.dart';

void main() {
  test('ScanF match tests', () {
    final scanf = ScanF('Real: %e, Value: %e, Float: %f, Int=%i, Octal=%o %[^:]:%f%%, %[a-c]%s');
    final result = scanf.match('Real: -3.14E+2, Value: -3.14E-2, Float: 3.14, Int=0xCAFEBABE, Octal=755 Progress:34.2%, abcdef');
    print(scanf);
    expect(result, [-314.0, -0.0314, 3.14, 3405691582, 493, 'Progress', 34.2, 'abc', 'def']);
  });
}
