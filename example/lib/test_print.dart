import 'dart:typed_data';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';

class TestPrint {
  final BlueThermalPrinter bluetooth;
  final Generator generator;

  TestPrint(this.bluetooth, this.generator);

  void print() async {
    List<int> bytes = [];
    bluetooth.isConnected.then((connected) async {
      bytes += generator.reset();
      // bytes += await generator.row([
      //   PosColumn(
      //       text: "这是第一行", width: 5, styles: PosStyles(align: PosAlign.left)),
      //   PosColumn(width: 7)
      // ]);
      // bytes += await generator
      //     .text("去去凄凄切切凄凄切切凄凄切切凄凄切切凄凄切切凄凄切切凄凄切切凄凄切切凄凄切切凄凄切切凄凄切切");
      bytes += await generator.row([
        PosColumn(text: "啦啦啦啦啦啦啦啦啊啦啦啦啦啦啦啦啦啦", width: 5, containsChinese: true),
        PosColumn(text: "-", width: 2),
        PosColumn(
          text: "-",
          width: 5,
        )
      ]);
      bytes += generator.cut();
      bluetooth.writeBytes(Uint8List.fromList(bytes));
    });
  }
}
