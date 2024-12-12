import 'dart:convert';
import 'dart:typed_data';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';

class TestPrint {
  final BlueThermalPrinter bluetooth;
  late Generator generator;
  final BluetoothDevice device;

  TestPrint(this.bluetooth, this.device);

  Future<List<int>> printB() async {
    List<int> bytes = [];

    // bytes += [
    //   27,
    //   97,
    //   48,
    // ];
    //* line 0 col 0
    bytes += [
      //* Pos
      27,
      36,
      15,
      0,
      //* Data
      206,
      210,
      206,
      210,
      206,
      210,
      206,
      210,
      206,
      210,
      206,
      210
    ];

    //* line 0 col 1
    bytes += [
      //* Pos
      27, 36, 154, 0,
      //* Data
      203, 196
    ];

    bytes += [10];

    //* line 1 col 0
    bytes += [
      //* Pos
      27, 36, 84, 0,
      //* Data
      206, 210,
      206, 210, 206, 210
    ];

    // bytes += [
    //   //* max paper size which is 372
    //   27, 36,
    //   92,
    //   1,
    //   //* Alignment Right
    //   27, 97, 50,
    //   206, 210, 206, 210
    // ];

    return bytes;
  }

  void print() async {
    List<int> bytes = [];
    await _initializeGenerator();

    if (await bluetooth.isConnected ?? false) {
      await bluetooth.disconnect();
    }
    await bluetooth.connect(device).timeout(Duration(seconds: 5));

    await bluetooth.isConnected.then((connected) async {
      //bytes += generator.reset();

      // bytes += await generator.row([
      //   PosColumn(text: "Item", width: 5),
      //   PosColumn(
      //       text: "Qty", styles: PosStyles(align: PosAlign.center), width: 2),
      //   PosColumn(
      //       text: "Price (MYR)",
      //       width: 5,
      //       styles: const PosStyles(align: PosAlign.right))
      // ]);

      // bytes += [27, 97, 49];
      // bytes += bytes + await generator.text("123");
      // bytes += [0x1D, 0x42, 0x02, 0x05];

      // bytes += await generator.row([
      //   PosColumn(
      //     text: '啦啦啦啦啦啦啦啦啦啦啦啦啦',
      //     width: 7,
      //     //styles: PosStyles(align: PosAlign.left),
      //   ),
      //   PosColumn(
      //     text: '123',
      //     width: 5,
      //     styles: PosStyles(align: PosAlign.right),
      //   ),
      // ]);

      // bytes += await generator.text("test");

      // bytes +=
      //     await generator.text("测试", styles: PosStyles(align: PosAlign.right));

      // bytes +=
      //     await generator.text("右边", styles: PosStyles(align: PosAlign.right));
      bytes += generator.reset();

      // bytes += await generator.row([
      //   PosColumn(
      //     text: ' ',
      //     width: 9,
      //     styles: PosStyles(align: PosAlign.left),
      //   ),
      //   PosColumn(
      //       text: '这是一个一个那么这样的测试啊',
      //       width: 3,
      //       styles: PosStyles(align: PosAlign.right)),
      // ]);
      warningPrint("Reset Bytes: $bytes");
      generator.currentLine = 0;

      // bytes += await generator.text("我我我");
      // bytes +=
      //     await generator.text("1", styles: PosStyles(align: PosAlign.right));
      //

      // bytes += await generator.row([
      //   PosColumn(
      //     text: 'ttttttttttttttttttttttttt',
      //     width: 5,
      //     styles: PosStyles(align: PosAlign.left),
      //   ),
      //   PosColumn(
      //     text: 'y',
      //     width: 7,
      //     styles: PosStyles(align: PosAlign.right),
      //   ),
      // ]);

      //  bytes += await printB();

      // bytes += await generator.row([
      //   PosColumn(
      //     text: '我我我我哦我我我我我',
      //     width: 5,
      //     styles: PosStyles(align: PosAlign.right),
      //   ),
      //   PosColumn(text: '四', width: 7, styles: PosStyles(align: PosAlign.left)),
      // ]);

      // bytes += await generator.row([
      //   PosColumn(
      //     text: '我我我我我我我我我',
      //     width: 5,
      //     styles: PosStyles(align: PosAlign.right),
      //   ),
      //   PosColumn(text: '四', width: 7, styles: PosStyles(align: PosAlign.left)),
      // ]);

      // bytes += [27, 97, 0]; // ESC a 0

      // warningPrint("Row Bytes: $bytes");

      // bytes += await generator.row([
      //   PosColumn(text: '啦啦啦啦啦啦啦', width: 5),
      //   // PosColumn(
      //   //     text: '1', width: 2, styles: PosStyles(align: PosAlign.center)),
      //   PosColumn(
      //     text: '13',
      //     width: 7,
      //     styles: const PosStyles(align: PosAlign.right),
      //   )
      // ]);

      // bytes += await generator.row([
      //   PosColumn(
      //       text: '啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦',
      //       width: 5,
      //       styles: PosStyles(align: PosAlign.right)),
      //   PosColumn(text: 't', width: 2),
      //   PosColumn(
      //     text: '13',
      //     width: 5,
      //     styles: const PosStyles(align: PosAlign.right),
      //   )
      // ]);

      // bytes += await generator.row([
      //   PosColumn(text: 'lalallalalalalallaalllllalalalalalal', width: 5),
      //   PosColumn(
      //       text: '1', width: 2, styles: PosStyles(align: PosAlign.center)),
      //   PosColumn(
      //       text: 13.toStringAsFixed(0),
      //       width: 5,
      //       styles: const PosStyles(align: PosAlign.right))
      // ]);

      // bytes += await generator.row([
      //   PosColumn(text: 'LAla', width: 5),
      //   PosColumn(text: '1', width: 2),
      //   PosColumn(
      //       text: 13.toStringAsFixed(0),
      //       width: 5,
      //       styles: const PosStyles(align: PosAlign.right))
      // ]);

      // //* Temp Data 1
      // bytes += await generator.row([
      //   PosColumn(text: '测试', width: 7),
      //   PosColumn(text: '1', width: 2),
      //   PosColumn(
      //       text: "13".toString(),
      //       width: 3,
      //       styles: const PosStyles(align: PosAlign.right))
      // ]);

      // bytes += await generator.row([
      //   PosColumn(text: '这是克嫩嫩嗯嗯撒了打开蓝色的喀喇昆仑山的卡萨卡里打孔老师的克拉克的开始', width: 5),
      //   PosColumn(text: '1', width: 2),
      //   PosColumn(
      //     text: 13.toStringAsFixed(0),
      //     width: 5,
      //     // styles: const PosStyles(align: PosAlign.right)
      //   )
      // ]);

      // //* Temp Data 1
      // bytes += await generator.row([
      //   PosColumn(text: 'apple', width: 5),
      //   PosColumn(text: '1', width: 2),
      //   PosColumn(
      //       text: 1.toStringAsFixed(0),
      //       width: 5,
      //       styles: const PosStyles(align: PosAlign.right))
      // ]);

      // bytes += await generator.row([
      //   PosColumn(text: "Semi-ripe", width: 5),
      //   PosColumn(
      //       text: "", width: 7, styles: const PosStyles(align: PosAlign.right)),
      // ]);

      // //* Temp Data 2
      // bytes += await generator.row([
      //   PosColumn(text: 'pineapple', width: 5),
      //   PosColumn(text: '6', width: 2),
      //   PosColumn(
      //       text: 24.toStringAsFixed(0),
      //       width: 5,
      //       styles: const PosStyles(align: PosAlign.right))
      // ]);
      await beepTest();
      bytes += generator.cut();
      bluetooth.writeBytes(Uint8List.fromList(bytes));
    });

    await bluetooth.disconnect();
  }

  Future<void> beepTest() async {
    List<int> beepBytes = [];

    // Choose one method to test
    //  beepBytes += generator.beep(); // Example using GS B n t

    // beepBytes += [27, 97, 49];
    // beepBytes += [0x1D, 0x42, 0x02, 0x05];
    // if (await bluetooth.isConnected ?? false) {
    //   bluetooth.writeBytes(Uint8List.fromList(beepBytes));
    //   // Wait a moment to ensure the command is processed
    //   await Future.delayed(Duration(seconds: 1));
    // }

    // await bluetooth.disconnect();
  }

  Future<void> _initializeGenerator() async {
    generator = Generator(PaperSize.mm58, await loadCustomProfile(),
        isKanji: true, spaceBetweenRows: 3, charset: "GBK");

    // generator = Generator(PaperSize.mm58, await loadCustomProfile(),
    //     isKanji: true, spaceBetweenRows: 0, useCharsetConvertor: false);
    //* EN
    // generator = Generator(PaperSize.mm58, await loadCustomProfile(),
    //     isKanji: false, spaceBetweenRows: 5, charset: "CP1252");
  }

  Future<CapabilityProfile> loadCustomProfile() async {
    final String data =
        await rootBundle.loadString('assets/custom_capabilities.json');
    final Map<String, dynamic> jsonData = json.decode(data);
    // AppLogger.logger.e(jsonData);

    return CapabilityProfile.fromMap(
        jsonData['profiles']['customDefault'], "customDefault");
  }
}
