import 'package:barcodes_flutter_app/core/typedefs/scan_option.dart';

abstract class BarcodeScannerInputPort {
  Stream<String> scanBarcode(
    String lineColor,
    String cancelButtonText,
    bool isShowFlashIcon,
    ScanOption scanMode,
  );
}
