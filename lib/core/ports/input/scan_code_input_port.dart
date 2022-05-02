import 'package:barcodes_flutter_app/core/typedefs/scan_option.dart';
import 'package:barcodes_flutter_app/modules/barcodes/models/barcode.dart';

abstract class ScanCodeInputPort {
  Stream<Barcode?> scanCode({
    required final ScanOption scanOption,
  });
}
