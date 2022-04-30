import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('should return a BarCode name', () async {
    const scanOption = ScanOption.BARCODE;
    final barCodeScanner = MockFlutterBarcodeScanner();
    final sut = ScanBarcodeUseCase(
      barcodeScanner: barCodeScanner,
    );

    when(() => sut.scanCode(scanOption: scanOption)).thenAnswer(
      (_) => Stream.value('test'),
    );

    sut.scanCode(scanOption: scanOption).listen(expectAsync1((code) {
      expect(code, 'test');
    }));
  });
}

typedef ScanOption = ScanMode;

class ScanBarcodeUseCase implements ScanCodeInputPort {
  const ScanBarcodeUseCase({
    required this.barcodeScanner,
  });

  final BarcodeScanner barcodeScanner;

  @override
  Stream<String> scanCode({required final ScanOption scanOption}) {
    return barcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      scanOption,
    );
  }
}

abstract class ScanCodeInputPort {
  Stream<String> scanCode({required final ScanOption scanOption});
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
