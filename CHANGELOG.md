## 1.1.3

Bugs fixed:

* preal.dart — Operator precedence: %f was incorrectly accepting e exponents
* pint/pdecimal/poctal/phex.dart — Integer scanners bypassed addMatch, breaking the %* ignore flag
* pset.dart — Infinite loop when a reject-set (%[^...]) reached end-of-input
* preal.dart — Removed dead value < 0 check (unreachable in Dart)
* scanf.dart — Dead l = c assignment after scanset range expansion
* ascii.dart — codeHome renamed to codeTilde (ASCII 126 is ~, not HOME)
* Tests: Expanded from 1 to 59, covering all scanners, all edge cases, and all code paths — confirmed at 100% line coverage.

## 1.1.2

* Negative flag fix
* Test improved

## 1.1.1

* Code coverage added
* "Scientific flag" no longer ignored
* Typos

## 1.1.1

* Code coverage added
* "Scientific flag" no longer ignored
* Typos

## 1.1.0

* Flutter dependancy removed, pure dart now
* Code reformatted

## 1.0.2+61

* Example added
* Fixed typos
* Fixed ScanF constructor, hangs if scanset has no terminating right bracket.

## 1.0.0+42

* Initial commit
