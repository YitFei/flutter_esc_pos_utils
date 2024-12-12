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
      bytes += generator.reset();
      bytes += await generator.row([
        PosColumn(text: "这是一个很长自我卡大量的啦啦；代码时，穆萨，穆萨旅客发送量；；了", width: 5),
        PosColumn(
            text: 1.toStringAsFixed(0),
            width: 2,
            styles: const PosStyles(align: PosAlign.right)),
        PosColumn(
            text: 100.toStringAsFixed(2),
            width: 5,
            styles: const PosStyles(align: PosAlign.right)),
      ]);

      bytes += await generator.row([
        PosColumn(text: "drinkA", width: 5),
        PosColumn(
            text: 1.toStringAsFixed(0),
            width: 2,
            styles: const PosStyles(align: PosAlign.right)),
        PosColumn(
            text: 100.toStringAsFixed(2),
            width: 5,
            styles: const PosStyles(align: PosAlign.right)),
      ]);

      warningPrint("Reset Bytes: $bytes");
      generator.currentLine = 0;

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
