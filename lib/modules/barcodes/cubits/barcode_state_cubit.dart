import 'package:barcodes_flutter_app/modules/barcodes/cubits/barcode_state.dart';
import 'package:barcodes_flutter_app/modules/barcodes/models/barcode.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeStateCubit extends Cubit<BarcodeContent> {
  BarcodeStateCubit()
      : super(
          BarcodeEmpty(Barcode.empty()),
        );

  void setMultipleContent(final Barcode barcode) {
    emit(BarcodeMultipleContent(barcode));
  }
}
