import 'package:barcodes_flutter_app/modules/barcodes/models/barcode.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class BarcodesCubit extends Cubit<List<Barcode>> {
  BarcodesCubit() : super([]);

  void addBarcode(Barcode barcode) {
    state.add(barcode);
    emit(state);
  }
}

void main() {
  blocTest<BarcodesCubit, List>(
    'should start with an empty list',
    build: () => BarcodesCubit(),
    expect: () => equals([]),
  );

  blocTest<BarcodesCubit, List>(
    'should add a barcode to the list',
    build: () => BarcodesCubit(),
    act: (cubit) => cubit.addBarcode(const Barcode(
      content: 'some barcode',
    )),
    expect: () => [
      equals([
        const Barcode(
          content: 'some barcode',
        )
      ])
    ],
  );

  blocTest<BarcodesCubit, List>(
    'should add 2 news barcodes to list',
    build: () => BarcodesCubit(),
    act: (cubit) => cubit
      ..addBarcode(const Barcode(
        content: 'some barcode',
      ))
      ..addBarcode(const Barcode(
        content: 'another barcode',
      )),
    expect: () => [
      equals([
        const Barcode(
          content: 'some barcode',
        ),
        const Barcode(
          content: 'another barcode',
        )
      ])
    ],
  );
}
