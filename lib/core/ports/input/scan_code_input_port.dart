import 'package:barcodes_flutter_app/core/typedefs/scan_option.dart';

abstract class ScanCodeInputPort {
  Stream<String> scanCode({
    required final ScanOption scanOption,
  });
}
