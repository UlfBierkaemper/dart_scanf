import 'package:flutter_test/flutter_test.dart';
import 'package:scanf/scanf.dart';

void main() {
  test('Scanf match tests', () {
    final scanf = ScanF('Pi: %f, Int=%i, Octal=%o %[^:]:%f%%, %[a-c]%s');
    final result = scanf.match('Pi: 3.14, Int=0xCAFEBABE, Octal=755 Progress:34.2%, abcdef');
    expect(result, [3.14, 3405691582, 493, 'Progress', 34.2, 'abc', 'def']);
  });
}
