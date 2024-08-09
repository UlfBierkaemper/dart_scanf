part of '../scanf.dart';

class ScanF {
  final String pattern;
  final specs = <Scanner>[];

  ScanF(this.pattern) {
    final text = <int>[];
    int i = 0, c = 0;

    void getCh() => c = i < pattern.length ? pattern.codeUnitAt(i++) : 0;

    void flushText() {
      if (text.isEmpty) {
        return;
      }
      specs.add(Literal(text: String.fromCharCodes(text)));
      text.clear();
    }

    int number() {
      int i = 0;
      do {
        i = i * 10 + (c - codeDigit0);
        getCh();
      } while (isDigit(c));
      return i;
    }

    void space() {
      specs.add(const WhiteSpaceScanner());
      do {
        getCh();
      } while (isWS(c));
    }

    bool scanset(int width, bool ignore) {
      final chars = <int>{};
      bool reject = false;

      void rightBracket() {
        specs.add(SetScanner(
          width: width,
          ignore: ignore,
          scanset: chars,
          reject: reject,
        ));
        getCh();
      }

      if (c == codeCaret) {
        reject = true;
        getCh();
      }
      while (c > 0) {
        int l = c;
        chars.add(c);
        getCh();
        switch (c) {
          case 0:
            return false;

          case codeMinus:
            getCh();
            if (c == codeRightBracket) {
              chars.add(codeMinus);
              rightBracket();
              return true;
            }
            while (l <= c) {
              chars.add(l++);
            }
            l = c;

          case codeRightBracket:
            rightBracket();
            return true;
        }
      }
      return false;
    }

    bool percent() {
      getCh();
      if (c == codePercent) {
        specs.add(const Literal(text: '%'));
        getCh();
        return true;
      }
      int width = -1;
      bool ignore = false;
      if (c == codeAsterisk) {
        ignore = true;
        getCh();
      }
      if (isDigit(c)) {
        width = number();
      }
      switch (c) {
        case codeCapitalI:
        case codeLowerCaseI:
          specs.add(IntScanner(width: width, ignore: ignore));
          getCh();
          return true;

        case codeCapitalD:
        case codeLowerCaseD:
        case codeCapitalU:
        case codeLowerCaseU:
          specs.add(DecimalScanner(width: width, ignore: ignore));
          getCh();
          return true;

        case codeCapitalO:
        case codeLowerCaseO:
          specs.add(OctalScanner(width: width, ignore: ignore));
          getCh();
          return true;

        case codeCapitalX:
        case codeLowerCaseX:
          specs.add(HexScanner(width: width, ignore: ignore));
          getCh();
          return true;

        case codeCapitalE:
        case codeLowerCaseE:
          specs.add(RealScanner(scientific: true, width: width, ignore: ignore));
          getCh();
          return true;

        case codeCapitalF:
        case codeLowerCaseF:
          specs.add(RealScanner(width: width, ignore: ignore));
          getCh();
          return true;

        case codeCapitalS:
        case codeLowerCaseS:
          specs.add(StringScanner(width: width, ignore: ignore));
          getCh();
          return true;

        case codeCapitalC:
        case codeLowerCaseC:
          specs.add(CharScanner(width: width, ignore: ignore));
          getCh();
          return true;

        case codeLeftBracket:
          getCh();
          return scanset(width, ignore);

        default:
          return false;
      }
    }

    bool compile() {
      switch (c) {
        case 0:
          flushText();
          return false;

        case codeSpace:
          flushText();
          space();
          return true;

        case codePercent:
          flushText();
          return percent();

        default:
          text.add(c);
          getCh();
          return true;
      }
    }

    getCh();
    while (compile()) {}
  }

  List match(String text) {
    final chars = CharGet(text);
    final matches = <Object>[];
    for (final spec in specs) {
      if (!spec.scan(chars, matches)) {
        break;
      }
    }
    return matches;
  }
}
