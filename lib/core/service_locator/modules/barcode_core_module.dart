import 'package:barcodes_flutter_app/core/ports/input/bar_code_scanner_input_port.dart';
import 'package:barcodes_flutter_app/core/ports/input/scan_code_input_port.dart';
import 'package:barcodes_flutter_app/core/usecases/bar_code_scanner_use_case.dart';
import 'package:barcodes_flutter_app/core/usecases/scan_barcode_use_case.dart';
import 'package:injectable/injectable.dart';

@module
abstract class BarcodeCoreModule {
  @singleton
  ScanCodeInputPort scanCodeInputPort(
    final ScanBarcodeUseCase useCase,
  ) =>
      useCase;

  @singleton
  BarcodeScannerInputPort barcodeScannerInputPort(
    final BarcodeScannerUseCase useCase,
  ) =>
      useCase;
}
