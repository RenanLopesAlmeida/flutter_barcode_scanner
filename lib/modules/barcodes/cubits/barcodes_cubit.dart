import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:barcodes_flutter_app/extensions/string_extension.dart';
import 'package:barcodes_flutter_app/utils/app_redirect_launcher.dart';
import 'package:barcodes_flutter_app/core/ports/input/scan_code_input_port.dart';
import 'package:barcodes_flutter_app/core/typedefs/scan_option.dart';
import 'package:barcodes_flutter_app/modules/barcodes/models/barcode.dart';

class BarcodesCubit extends Cubit<List<Barcode>> {
  BarcodesCubit({
    required final ScanCodeInputPort scanBarCodeInputPort,
    required final RedirectLauncher redirectLauncher,
  })  : _scanBarCodeInputPort = scanBarCodeInputPort,
        _redirectLauncher = redirectLauncher,
        super([]);

  final ScanCodeInputPort _scanBarCodeInputPort;
  final RedirectLauncher _redirectLauncher;

  void addBarcode(Barcode barcode) {
    final hasURL = barcode.content.isURL;

    Barcode updatedBarcode = barcode;

    if (hasURL) {
      updatedBarcode = barcode.copyWith(isContentUrl: true);
    }

    emit([...state, updatedBarcode]);
  }

  Future<Barcode?> scanBarCode(final ScanOption scanOption) async {
    final barcode = await _scanBarCodeInputPort
        .scanCode(
          scanOption: scanOption,
        )
        .last;

    final hasMultipleContents = _hasMultipleContents(barcode: barcode);

    if (hasMultipleContents) {
      return barcode.copyWith(hasMultipleContents: true);
    }

    addBarcode(barcode);

    final isContentUrl = barcode.content.isURL;

    final updatedBarcode = barcode.copyWith(isContentUrl: isContentUrl);

    return updatedBarcode;
  }

  Future<void> launchURL(String url) async {
    await _redirectLauncher.launchURL(url);
  }

  void removeBarcode(Barcode barcode) {
    state.removeWhere((element) => element == barcode);

    emit([...state]);
  }

  bool _hasMultipleContents({
    required final Barcode barcode,
    final String delimiter = ';',
  }) {
    return barcode.content.contains(delimiter);
  }

  List<Barcode> extractContentByDelimiter({
    required final Barcode barcode,
    final String delimiter = ';',
  }) {
    List<Barcode> barcodes = [];
    final contents = barcode.content.split(delimiter);

    for (var content in contents) {
      barcodes.add(Barcode(content: content.trim()));
    }

    return barcodes;
  }
}
