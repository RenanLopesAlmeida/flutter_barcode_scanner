import 'package:barcodes_flutter_app/modules/barcodes/models/barcode.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class BarcodesCubit extends Cubit<List<Barcode>> {
  BarcodesCubit() : super([]);
}

void main() {
  blocTest<BarcodesCubit, List>(
    'should start with an empty list',
    build: () => BarcodesCubit(),
    expect: () => equals([]),
  );
}
