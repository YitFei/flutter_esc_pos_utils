enum PosAlign { left, center, right }

enum PosCutMode { full, partial }

enum PosFontType { fontA, fontB }

enum PosDrawer { pin2, pin5 }

/// Choose image printing function
/// bitImageRaster: GS v 0 (obsolete)
/// graphics: GS ( L
enum PosImageFn { bitImageRaster, graphics }

class PosTextSize {
  const PosTextSize._internal(this.value);
  final int value;
  static const size1 = PosTextSize._internal(1);
  static const size2 = PosTextSize._internal(2);
  static const size3 = PosTextSize._internal(3);
  static const size4 = PosTextSize._internal(4);
  static const size5 = PosTextSize._internal(5);
  static const size6 = PosTextSize._internal(6);
  static const size7 = PosTextSize._internal(7);
  static const size8 = PosTextSize._internal(8);

  static int decSize(PosTextSize height, PosTextSize width) =>
      16 * (width.value - 1) + (height.value - 1);
}

class PaperSize {
  const PaperSize._internal(this.value, this.name);
  final int value;
  final String name;
  static const mm58 = PaperSize._internal(1, "58mm");
  static const mm72 = PaperSize._internal(3, "72mm");
  static const mm80 = PaperSize._internal(2, "80mm");

  //TODO
  static List<PaperSize> get values => [
        mm58,
        mm72,
        mm80,
      ];

  int get width => value == PaperSize.mm58.value
      ? 372
      : value == PaperSize.mm72.value
          ? 503
          : 558;
}

class PosBeepDuration {
  const PosBeepDuration._internal(this.value);
  final int value;
  static const beep50ms = PosBeepDuration._internal(1);
  static const beep100ms = PosBeepDuration._internal(2);
  static const beep150ms = PosBeepDuration._internal(3);
  static const beep200ms = PosBeepDuration._internal(4);
  static const beep250ms = PosBeepDuration._internal(5);
  static const beep300ms = PosBeepDuration._internal(6);
  static const beep350ms = PosBeepDuration._internal(7);
  static const beep400ms = PosBeepDuration._internal(8);
  static const beep450ms = PosBeepDuration._internal(9);
}
