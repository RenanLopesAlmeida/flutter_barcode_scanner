import 'package:barcodes_flutter_app/modules/barcodes/cubits/barcode_picker_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  blocTest<BarcodePickerCubit, int>(
    'should be able to start with 0 value',
    build: () => BarcodePickerCubit(),
    verify: (cubit) => expect(cubit.state, 0),
  );

  blocTest<BarcodePickerCubit, int>(
    'should be able to emit a new value',
    build: () => BarcodePickerCubit(),
    act: (cubit) => cubit.setValue(1),
    verify: (cubit) => expect(cubit.state, 1),
  );
}
