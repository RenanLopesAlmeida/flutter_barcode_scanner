import 'package:barcodes_flutter_app/core/ports/input/scan_code_input_port.dart';
import 'package:barcodes_flutter_app/core/typedefs/scan_option.dart';
import 'package:barcodes_flutter_app/modules/barcodes/cubits/barcodes_cubit.dart';
import 'package:barcodes_flutter_app/modules/barcodes/models/barcode.dart';
import 'package:barcodes_flutter_app/utils/app_redirect_launcher.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_bar_code_scanner_input_port.dart';

class MockScanCodeInputPort extends Mock implements ScanCodeInputPort {}

void main() {
  late MockBarcodeScannerInputPort mockBarcodeScannerInputPort;
  late MockScanCodeInputPort mockScanCodeInputPort;
  late MockRedirectLauncher mockRedirectLauncher;
  late BarcodesCubit barcodesCubit;
  late String url;
  late String barcodeContent;

  setUp(() {
    url = 'https://www.google.com/';
    barcodeContent = faker.address.person.name();
    mockBarcodeScannerInputPort = MockBarcodeScannerInputPort();
    mockScanCodeInputPort = MockScanCodeInputPort();
    mockRedirectLauncher = MockRedirectLauncher();
    barcodesCubit = BarcodesCubit(
      scanBarCodeInputPort: mockScanCodeInputPort,
      redirectLauncher: mockRedirectLauncher,
    );
  });
  blocTest<BarcodesCubit, List>(
    'should start with an empty list',
    build: () => barcodesCubit,
    expect: () => equals([]),
  );

  blocTest<BarcodesCubit, List>(
    'should add a barcode to the list',
    build: () => barcodesCubit,
    act: (cubit) => cubit.addBarcode(Barcode(
      content: barcodeContent,
    )),
    expect: () => [
      equals([
        Barcode(
          content: barcodeContent,
        )
      ])
    ],
  );

  blocTest<BarcodesCubit, List>('should add 2 news barcodes to list',
      build: () => barcodesCubit,
      act: (cubit) {
        cubit
          ..addBarcode(const Barcode(
            content: 'some barcode',
          ))
          ..addBarcode(const Barcode(
            content: 'another barcode',
          ));
      },
      verify: (cubit) {
        expect(cubit.state.length, 2);
      });

  blocTest<BarcodesCubit, List>(
    'scanBarCode method should call ScanBarCodeInputPort',
    build: () => barcodesCubit,
    act: (cubit) {
      when(
        () => mockScanCodeInputPort.scanCode(
          scanOption: ScanOption.BARCODE,
        ),
      ).thenAnswer(
        (_) => mockBarcodeScannerInputPort.scanBarcode(
          '',
          '',
          true,
          ScanOption.BARCODE,
        ),
      );

      when(
        () => mockBarcodeScannerInputPort.scanBarcode(
          '',
          '',
          true,
          ScanOption.BARCODE,
        ),
      ).thenAnswer(
        (_) => Stream.value(
          Barcode(content: barcodeContent),
        ),
      );

      cubit.scanBarCode(ScanOption.BARCODE);
    },
    expect: () => [
      equals([Barcode(content: barcodeContent)])
    ],
    verify: (cubit) => verify(() => mockBarcodeScannerInputPort.scanBarcode(
          '',
          '',
          true,
          ScanOption.BARCODE,
        )).called(1),
  );

  blocTest<BarcodesCubit, List>(
    'ensure scanBarCode method adds a barcode to the list',
    build: () => barcodesCubit,
    act: (cubit) {
      when(
        () => mockScanCodeInputPort.scanCode(
          scanOption: ScanOption.BARCODE,
        ),
      ).thenAnswer(
        (_) => mockBarcodeScannerInputPort.scanBarcode(
          '',
          '',
          true,
          ScanOption.BARCODE,
        ),
      );

      when(
        () => mockBarcodeScannerInputPort.scanBarcode(
          '',
          '',
          true,
          ScanOption.BARCODE,
        ),
      ).thenAnswer(
        (_) => Stream.value(
          Barcode(content: barcodeContent),
        ),
      );

      cubit.scanBarCode(ScanOption.BARCODE);
    },
    expect: () => [
      equals([Barcode(content: barcodeContent)])
    ],
    verify: (cubit) {
      expect(cubit.state.length, 1);
    },
  );

  blocTest<BarcodesCubit, List>(
    'should be able to call redirect launcher',
    build: () => barcodesCubit,
    act: (cubit) async {
      when(
        () => mockRedirectLauncher.launchURL(url),
      ).thenAnswer((final _) async => _);

      await cubit.launchURL(url);
    },
    verify: (cubit) => verify(
      () => mockRedirectLauncher.launchURL(url),
    ).called(1),
  );

  blocTest<BarcodesCubit, List>(
    'should be able to identify if there\'s an url on barcode content',
    build: () => barcodesCubit,
    act: (cubit) => cubit.addBarcode(
      Barcode(
        content: url,
      ),
    ),
    expect: () => [
      equals([
        Barcode(
          content: url,
          isContentUrl: true,
        ),
      ])
    ],
  );

  blocTest<BarcodesCubit, List>(
    'should be able to distinct if there\'s an url on barcode content',
    build: () => barcodesCubit,
    act: (cubit) => cubit.addBarcode(
      Barcode(
        content: barcodeContent,
      ),
    ),
    expect: () => [
      equals([
        Barcode(
          content: barcodeContent,
          isContentUrl: false,
        ),
      ])
    ],
  );

  blocTest<BarcodesCubit, List>(
    'should be able to delete a specific barcode from the list',
    build: () => barcodesCubit,
    seed: () => <Barcode>[
      Barcode(
        content: barcodeContent,
      ),
    ],
    act: (cubit) => cubit
      ..addBarcode(
        const Barcode(
          content: 'new content',
        ),
      )
      ..removeBarcode(
        Barcode(
          content: barcodeContent,
        ),
      ),
    verify: (cubit) {
      expect(cubit.state.length, 1);
    },
  );

  blocTest<BarcodesCubit, List>(
    'should be able to extract multiple contents on the same barcode',
    build: () => barcodesCubit,
    seed: () => <Barcode>[
      Barcode(
        content: barcodeContent + '; new content ; another content',
      ),
    ],
    act: (cubit) {
      final barcodes = cubit.extractContentByDelimiter(
        barcode: Barcode(
          content: barcodeContent + '; new content ; another content',
        ),
      );

      cubit.emit(barcodes);
    },
    verify: (cubit) {
      expect(cubit.state.length, 3);
    },
  );
}

class MockRedirectLauncher extends Mock implements RedirectLauncher {}
