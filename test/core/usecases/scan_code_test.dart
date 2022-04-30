import 'package:barcodes_flutter_app/core/ports/input/bar_code_scanner_input_port.dart';
import 'package:barcodes_flutter_app/core/ports/input/scan_code_input_port.dart';
import 'package:barcodes_flutter_app/core/typedefs/scan_option.dart';
import 'package:barcodes_flutter_app/core/usecases/scan_barcode_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('should return a BarCode name', () async {
    const scanOption = ScanOption.BARCODE;
    final barCodeScanner = MockFlutterBarcodeScanner();
    final sut = ScanBarcodeUseCase(
      barcodeScannerInputPort: barCodeScanner,
    );

    when(() => sut.scanCode(scanOption: scanOption)).thenAnswer(
      (_) => Stream.value('test'),
    );

    sut.scanCode(scanOption: scanOption).listen(expectAsync1((code) {
      expect(code, 'test');
    }));
  });
}

class MockScanUseCase extends Mock implements ScanCodeInputPort {}

class MockFlutterBarcodeScanner extends Mock
    implements BarcodeScannerInputPort {}
