import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('should return a BarCode name', () async {
    final barCodeScanner = MockFlutterBarcodeScanner();
    final sut = ScanBarcodeUseCase(barCodeScanner);

    when(() => sut.scanCode()).thenAnswer(
      (_) => Stream.value('test'),
    );

    sut.scanCode().listen(expectAsync1((code) {
      expect(code, 'test');
    }));
  });
}

class ScanBarcodeUseCase implements ScanCodeInputPort {
  const ScanBarcodeUseCase(this.barcodeScanner);
  final BarcodeScanner barcodeScanner;

  @override
  Stream<String> scanCode() {
    return barcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );
  }
}

abstract class ScanCodeInputPort {
  Stream<String> scanCode();
}

abstract class BarcodeScanner {
  Stream<String> scanBarcode(
    String lineColor,
    String cancelButtonText,
    bool isShowFlashIcon,
    ScanMode scanMode,
  );
}

class MockScanUseCase extends Mock implements ScanCodeInputPort {}

class MockFlutterBarcodeScanner extends Mock implements BarcodeScanner {}
