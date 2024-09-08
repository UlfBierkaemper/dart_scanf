part of '../scanf.dart';

/// Floating point number scanner, used for %f or %e

class RealScanner extends Percent {
  /// Enabled scanning of exponential postfixes.
  /// Example: 1.234E-4
  final bool scientific;

  /// Generative constructor, forwards to super
  /// The "scientific" boolean enables the scanning of exponential postfixes
  const RealScanner({
    this.scientific = false,
    super.width,
    required super.ignore,
  });

  @override
  bool scan(CharGet chars, List matches) {
    const int mantissaDigits = 16;
    const int exponentReal = 308;
    chars.skipWS();
    if (chars.ch > 0) {
      int w = width;
      int mantissa = 0, exponent = 0, digits = 0;
      final negative = chars.ch == codeMinus;
      if (negative) {
        chars.getCh();
        w--;
      }
      while (isDigit(chars.ch) && w-- != 0) {
        if (digits <= mantissaDigits) {
          mantissa = mantissa * 10 + (chars.ch - codeDigit0);
          if (mantissa > 0) {
            digits++;
          }
        }
        chars.getCh();
      }
      if (chars.ch == codeDot || chars.ch == codeComma) {
        chars.getCh();
        w--;
        while (isDigit(chars.ch) && w-- != 0) {
          if (digits <= mantissaDigits) {
            mantissa = mantissa * 10 + (chars.ch - codeDigit0);
            if (mantissa > 0) {
              digits++;
            }
            exponent--;
          }
          chars.getCh();
        }
      }
      double result = mantissa.toDouble();
      if (scientific && chars.ch == codeCapitalE ||
          chars.ch == codeLowerCaseE) {
        chars.getCh();
        w--;
        int value = 0;
        int sign = 1;
        if (chars.ch == codePlus) {
          chars.getCh();
          w--;
        } else if (chars.ch == codeMinus) {
          chars.getCh();
          w--;
          sign = -1;
        }
        while (isDigit(chars.ch) && w-- != 0) {
          value = value * 10 + (chars.ch - codeDigit0);
          if (value < 0) {
            return false;
          }
          chars.getCh();
        }
        exponent += sign * value;
      }
      if (exponent != 0) {
        final digitExponent = exponent + digits;
        if (digitExponent > exponentReal) {
          return false;
        }
        if (digitExponent <= -exponentReal) {
          result = 0.0;
        } else {
          int s = exponent < 0 ? -exponent : exponent;
          double t = 1.0;
          double d = 10.0;
          do {
            while (s.isEven) {
              s >>= 1;
              d *= d;
            }
            s--;
            t *= d;
          } while (s > 0);
          result = exponent < 0 ? result / t : result * t;
        }
      }
      addMatch(matches, result);
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return '${super.toString()}, scientific=$scientific';
  }
}
