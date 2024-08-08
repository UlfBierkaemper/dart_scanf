part of '../scanf.dart';

class CharGet {
  final String text;
  int _index = 0;
  int _ch = -1;

  int get ch => _ch;
  int get remaining => text.length - _index;

  CharGet(this.text) {
    getCh();
  }

  void getCh() {
    if (_index < text.length) {
      _ch = text.codeUnitAt(_index++);
    } else {
      _ch = -1;
    }
  }

  void skipWS() {
    while (isWS(_ch)) {
      getCh();
    }
  }
}

bool isWS(int ch) => ch > 0 && ch <= codeSpace;
bool isVisible(int ch) => ch > codeSpace;
bool isDigit(int ch) => ch >= codeDigit0 && ch <= codeDigit9;

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
