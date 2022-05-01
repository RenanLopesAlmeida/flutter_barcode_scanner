import 'package:barcodes_flutter_app/extensions/string_extension.dart';
import 'package:barcodes_flutter_app/utils/app_redirect_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    state.add(updatedBarcode);
    emit(state);
  }

  Future<Barcode?> scanBarCode(final ScanOption scanOption) async {
    final barcode = await _scanBarCodeInputPort
        .scanCode(
          scanOption: scanOption,
        )
        .last;

    addBarcode(barcode);

    final isContentUrl = barcode.content.isURL;

    final updatedBarcode = barcode.copyWith(isContentUrl: isContentUrl);

    return updatedBarcode;
  }

  Future<void> launchURL(String url) async {
    await _redirectLauncher.launchURL(url);
  }
}
