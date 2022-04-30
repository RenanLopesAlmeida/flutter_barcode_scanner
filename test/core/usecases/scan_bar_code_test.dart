import 'package:barcodes_flutter_app/core/typedefs/scan_option.dart';
import 'package:barcodes_flutter_app/core/usecases/scan_barcode_use_case.dart';
import 'package:barcodes_flutter_app/modules/barcodes/models/barcode.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_bar_code_scanner_input_port.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('should return a BarCode name', () async {
    const scanOption = ScanOption.BARCODE;
    final barCodeScanner = MockBarcodeScannerInputPort();
    final sut = ScanBarcodeUseCase(
      barcodeScannerInputPort: barCodeScanner,
    );

    when(() => sut.scanCode(scanOption: scanOption)).thenAnswer(
      (_) => Stream.value(const Barcode(
        content: 'test',
      )),
    );

    sut.scanCode(scanOption: scanOption).listen(expectAsync1((code) {
      expect(code.content, 'test');
    }));
  });
}
