import 'package:scanf/scanf.dart';
import 'package:test/test.dart';

void main() {
  group('ScanF comprehensive match', () {
    test('original pattern', () {
      final scanf = ScanF(
          'Real: %e, Value: %e, Float: %f, Int=%i, Octal=%o %[^:]:%f%%, %[a-c]%s');
      final result = scanf.match(
          'Real: -3.14E+2, Value: -3.14E-2, Float: 3.14, Int=0xCAFEBABE, Octal=755 Progress:34.2%, abcdef');
      print(scanf);
      expect(result, [
        -314.0,
        -0.0314,
        3.14,
        3405691582,
        493,
        'Progress',
        34.2,
        'abc',
        'def'
      ]);
    });
  });

  group('DecimalScanner (%d/%u)', () {
    test('positive integer', () => expect(ScanF('%d').match('42'), [42]));
    test('negative integer', () => expect(ScanF('%d').match('-42'), [-42]));
    test('plus sign', () => expect(ScanF('%d').match('+42'), [42]));
    test('width limit', () => expect(ScanF('%3d').match('12345'), [123]));
    test('%D uppercase', () => expect(ScanF('%D').match('99'), [99]));
    test('%u', () => expect(ScanF('%u').match('100'), [100]));
    test('%U', () => expect(ScanF('%U').match('100'), [100]));
    test('ignore %*d', () => expect(ScanF('%*d%d').match('10 20'), [20]));
    test('no match stops scan',
        () => expect(ScanF('%d%d').match('5 abc'), [5]));
  });

  group('HexScanner (%x/%X)', () {
    test('without 0x prefix', () => expect(ScanF('%x').match('1a'), [26]));
    test('with 0x prefix', () => expect(ScanF('%x').match('0x1a'), [26]));
    test('with 0X prefix', () => expect(ScanF('%x').match('0X1A'), [26]));
    test('%X uppercase format', () => expect(ScanF('%X').match('ff'), [255]));
    test('negative', () => expect(ScanF('%x').match('-ff'), [-255]));
    test('ignore %*x', () => expect(ScanF('%*x %x').match('ff aa'), [170]));
    test('0x with zero value', () => expect(ScanF('%x').match('0x0'), [0]));
  });

  group('OctalScanner (%o)', () {
    test('negative octal', () => expect(ScanF('%o').match('-755'), [-493]));
    test('ignore %*o', () => expect(ScanF('%*o %o').match('52 17'), [15]));
    test('invalid digit 9 stops scan',
        () => expect(ScanF('%o').match('9'), []));
  });

  group('IntScanner (%i) variants', () {
    test('plain decimal', () => expect(ScanF('%i').match('42'), [42]));
    test('octal prefix', () => expect(ScanF('%i').match('052'), [42]));
    test('just zero', () => expect(ScanF('%i').match('0'), [0]));
    test('0x hex prefix', () => expect(ScanF('%i').match('0x2a'), [42]));
    test('0X capital hex prefix', () => expect(ScanF('%i').match('0X2A'), [42]));
    test('plus sign', () => expect(ScanF('%i').match('+5'), [5]));
    test('ignore %*i', () => expect(ScanF('%*i %i').match('0xff 42'), [42]));
    test('%I uppercase', () => expect(ScanF('%I').match('7'), [7]));
  });

  group('CharScanner (%c)', () {
    test('single char', () => expect(ScanF('%c').match('A'), ['A']));
    test('width > 1', () => expect(ScanF('%3c').match('ABC'), ['ABC']));
    test('empty input returns empty', () => expect(ScanF('%c').match(''), []));
    test('ignore %*c', () => expect(ScanF('%*c%c').match('AB'), ['B']));
    test('%C uppercase', () => expect(ScanF('%C').match('Z'), ['Z']));
  });

  group('RealScanner (%f/%e)', () {
    test('comma as decimal separator',
        () => expect(ScanF('%f').match('3,14'), [3.14]));
    test('empty input returns empty', () => expect(ScanF('%f').match(''), []));
    test('exponent overflow returns empty',
        () => expect(ScanF('%e').match('1e400'), []));
    test('exponent underflow returns 0.0',
        () => expect(ScanF('%e').match('1e-400'), [0.0]));
    test('positive exponent scaling',
        () => expect(ScanF('%e').match('1.5e3'), [1500.0]));
    test('ignore %*f', () => expect(ScanF('%*f %f').match('1.0 2.5'), [2.5]));
    test('ignore %*e', () => expect(ScanF('%*e %e').match('1e2 3e4'), [30000.0]));
    test('%F uppercase', () => expect(ScanF('%F').match('1.5'), [1.5]));
    test('%E uppercase', () => expect(ScanF('%E').match('2e1'), [20.0]));
  });

  group('SetScanner (%[...])', () {
    test('without reject', () => expect(ScanF('%[abc]').match('abcdef'), ['abc']));
    test('no match returns empty', () => expect(ScanF('%[abc]').match('xyz'), []));
    test('width limit', () => expect(ScanF('%2[abc]').match('abcabc'), ['ab']));
    test('ignore %*[...]',
        () => expect(ScanF('%*[^,],%[^,]').match('skip,keep'), ['keep']));
    test('literal minus at end of set',
        () => expect(ScanF('%[a-]').match('a-b'), ['a-']));
  });

  group('StringScanner (%s)', () {
    test('empty input returns empty', () => expect(ScanF('%s').match(''), []));
    test('width limit', () => expect(ScanF('%3s').match('hello'), ['hel']));
    test('ignore %*s', () => expect(ScanF('%*s %s').match('skip keep'), ['keep']));
    test('%S uppercase', () => expect(ScanF('%S').match('word'), ['word']));
  });

  group('Literal scanner', () {
    test('mismatch stops scan',
        () => expect(ScanF('hello%d').match('world42'), []));
    test('partial mismatch stops scan',
        () => expect(ScanF('%dhello%d').match('5helXo3'), [5]));
  });

  group('WhiteSpaceScanner', () {
    test('no whitespace in input still succeeds',
        () => expect(ScanF('a %d').match('a5'), [5]));
  });

  group('Pattern edge cases', () {
    test('unknown format specifier stops compilation',
        () => expect(ScanF('%q').match('anything'), []));
    test('unterminated scanset (immediate)',
        () => expect(ScanF('%[').match('abc'), []));
    test('unterminated scanset (after chars)',
        () => expect(ScanF('%[abc').match('abc'), []));
    test('percent literal %%',
        () => expect(ScanF('%%%d').match('%42'), [42]));
  });

  group('CharGet', () {
    test('remaining decreases as chars are consumed', () {
      final cg = CharGet('hello');
      expect(cg.remaining, 4);
      cg.getCh();
      expect(cg.remaining, 3);
    });
  });
}
