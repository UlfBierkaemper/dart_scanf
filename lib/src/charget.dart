part of '../scanf.dart';

/// Gets characters char by char from input text.

class CharGet {
  /// The input text
  final String text;

  int _index = 0;
  int _ch = -1;

  /// Gets the next character from the input text string
  int get ch => _ch;

  /// Number of remainig characters of the input text
  int get remaining => text.length - _index;

  /// Constructor with input text
  CharGet(this.text) {
    getCh();
  }

  /// Advances the imaginary "cursor" to the nech character
  void getCh() {
    if (_index < text.length) {
      _ch = text.codeUnitAt(_index++);
    } else {
      _ch = -1;
    }
  }

  /// Skips white spaces, used for reading visible characters
  void skipWS() {
    while (isWS(_ch)) {
      getCh();
    }
  }
}

/// True if "ch" is a white space character
bool isWS(int ch) => ch > 0 && ch <= codeSpace;

/// True if "ch" is a visible character, convenience function
bool isVisible(int ch) => ch > codeSpace;

/// True if "ch" is in the range from "0" to "9"
bool isDigit(int ch) => ch >= codeDigit0 && ch <= codeDigit9;

/// Returns the integer value of a digit character for a given number base
int nextDigit(CharGet chars, int base) {
  const charToDigitMap = <int, int>{
    codeDigit0: 0,
    codeDigit1: 1,
    codeDigit2: 2,
    codeDigit3: 3,
    codeDigit4: 4,
    codeDigit5: 5,
    codeDigit6: 6,
    codeDigit7: 7,
    codeDigit8: 8,
    codeDigit9: 9,
    codeCapitalA: 10,
    codeCapitalB: 11,
    codeCapitalC: 12,
    codeCapitalD: 13,
    codeCapitalE: 14,
    codeCapitalF: 15,
    codeLowerCaseA: 10,
    codeLowerCaseB: 11,
    codeLowerCaseC: 12,
    codeLowerCaseD: 13,
    codeLowerCaseE: 14,
    codeLowerCaseF: 15,
  };

  final digit = charToDigitMap[chars.ch];
  if (digit == null) {
    return -1;
  }
  if (digit >= base) {
    return -1;
  }
  chars.getCh();
  return digit;
}
