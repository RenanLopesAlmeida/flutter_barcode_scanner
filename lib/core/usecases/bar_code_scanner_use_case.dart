import 'package:barcodes_flutter_app/core/ports/input/bar_code_scanner_input_port.dart';
import 'package:barcodes_flutter_app/core/typedefs/scan_option.dart';
import 'package:barcodes_flutter_app/modules/barcodes/models/barcode.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:rxdart/rxdart.dart';

class BarcodeScannerUseCase implements BarcodeScannerInputPort {
  @override
  Stream<Barcode> scanBarcode(
    String lineColor,
    String cancelButtonText,
    bool isShowFlashIcon,
    ScanOption scanMode,
  ) {
    return Stream.fromFuture(
      FlutterBarcodeScanner.scanBarcode(
        lineColor,
        cancelButtonText,
        isShowFlashIcon,
        scanMode,
      ),
    ).switchMap(
      (final content) => Stream.value(
        Barcode(
          content: content,
        ),
      ),
    );
  }
}
