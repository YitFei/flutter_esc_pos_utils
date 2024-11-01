import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';

Future<List<int>> main() async {
  final profile = await CapabilityProfile.load();
  final generator = Generator(PaperSize.mm80, profile);
  List<int> bytes = [];

  bytes += await generator.text(
      'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  bytes += await generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
      styles: const PosStyles(codeTable: 'CP1252'));
  bytes += await generator.text('Special 2: blåbærgrød',
      styles: const PosStyles(codeTable: 'CP1252'));

  bytes +=
      await generator.text('Bold text', styles: const PosStyles(bold: true));
  bytes += await generator.text('Reverse text',
      styles: const PosStyles(reverse: true));
  bytes += await generator.text('Underlined text',
      styles: const PosStyles(underline: true), linesAfter: 1);
  bytes += await generator.text('Align left',
      styles: const PosStyles(align: PosAlign.left));
  bytes += await generator.text('Align center',
      styles: const PosStyles(align: PosAlign.center));
  bytes += await generator.text('Align right',
      styles: const PosStyles(align: PosAlign.right), linesAfter: 1);

  bytes += await generator.row([
    PosColumn(
      text: 'col3',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'col6',
      width: 6,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'col3',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
  ]);

  bytes += await generator.text('Text size 200%',
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ));

  // Print barcode
  final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
  bytes += await generator.barcode(Barcode.upcA(barData));

  bytes += generator.feed(2);
  bytes += generator.cut();
  return bytes;
}
