import 'package:barcodes_flutter_app/core/ports/input/bar_code_scanner_input_port.dart';
import 'package:barcodes_flutter_app/core/ports/input/scan_code_input_port.dart';
import 'package:barcodes_flutter_app/core/typedefs/scan_option.dart';

class ScanBarcodeUseCase implements ScanCodeInputPort {
  const ScanBarcodeUseCase({
    required this.barcodeScannerInputPort,
  });

  final BarcodeScannerInputPort barcodeScannerInputPort;

  @override
  Stream<String> scanCode({required final ScanOption scanOption}) {
    return barcodeScannerInputPort.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      scanOption,
    );
  }
}
