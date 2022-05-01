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
    state.add(barcode);
    emit(state);
  }

  void scanBarCode(final ScanOption scanOption) {
    _scanBarCodeInputPort.scanCode(scanOption: scanOption).listen((
      final barcode,
    ) {
      addBarcode(barcode);
    }, onError: (final error, final stackTrace) {
      addError(error, stackTrace);
    });
  }

  Future<void> launchURL(String url) async {
    await _redirectLauncher.launchURL(url);
  }
}
