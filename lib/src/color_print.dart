import 'package:flutter/foundation.dart';

class POSDebugPrinting {
  bool showLog = false;

  static final POSDebugPrinting instance = POSDebugPrinting._internal();

  POSDebugPrinting._internal();

  void init({bool showLog = false}) {
    this.showLog = showLog;
  }
}

void infoPrint(String message) {
  colorPrint(message, fgColor: XtermColorType.skyBlue1);
}

void warningPrint(String message) {
  colorPrint(message, fgColor: XtermColorType.yellow);
}

void successPrint(String message) {
  colorPrint(message, fgColor: XtermColorType.lime);
}

void errorPrint(String message) {
  colorPrint(message, fgColor: XtermColorType.red);
}

void colorPrint(String message,
    {XtermColorType? fgColor, XtermColorType? bgColor}) {
  if (!POSDebugPrinting.instance.showLog) return;
  const ansiEsc = "\x1B[";

  var fgColorCode = fgColor != null ? '${ansiEsc}38;5;${fgColor.code}m' : '';
  var bgColorCode = bgColor != null ? '${ansiEsc}48;5;${bgColor.code}m' : '';

  try {
    debugPrint("$fgColorCode$bgColorCode$message${ansiEsc}0m");
  } catch (e) {
    debugPrint(message);
  }
}

//* https://www.ditig.com/publications/256-colors-cheat-sheet
//* XtermColorType
enum XtermColorType {
  black,
  maroon,
  green,
  olive,
  navy,
  purple,
  teal,
  silver,
  grey,
  red,
  lime,
  yellow,
  blue,
  fuchsia,
  aqua,
  white,
  skyBlue1,
}

extension XTermColorCodeExtension on XtermColorType {
  int get code {
    switch (this) {
      case XtermColorType.black:
        return 0;
      case XtermColorType.maroon:
        return 1;
      case XtermColorType.green:
        return 2;
      case XtermColorType.olive:
        return 3;
      case XtermColorType.navy:
        return 4;
      case XtermColorType.purple:
        return 5;
      case XtermColorType.teal:
        return 6;
      case XtermColorType.silver:
        return 7;
      case XtermColorType.grey:
        return 8;
      case XtermColorType.red:
        return 9;
      case XtermColorType.lime:
        return 10;
      case XtermColorType.yellow:
        return 11;
      case XtermColorType.blue:
        return 12;
      case XtermColorType.fuchsia:
        return 13;
      case XtermColorType.aqua:
        return 14;
      case XtermColorType.white:
        return 15;
      case XtermColorType.skyBlue1:
        return 117;
    }
  }
}
