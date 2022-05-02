import 'package:barcodes_flutter_app/modules/barcodes/models/barcode.dart';

abstract class BarcodeContent {
  BarcodeContent(Barcode barcode) : _barcode = barcode;

  final Barcode _barcode;

  Barcode get barcode => _barcode;
}

class BarcodeEmpty extends BarcodeContent {
  BarcodeEmpty(Barcode barcode) : super(barcode);
}

class BarcodeSingleContent extends BarcodeContent {
  BarcodeSingleContent(Barcode barcode) : super(barcode);
}

class BarcodeMultipleContent extends BarcodeContent {
  BarcodeMultipleContent(Barcode barcode) : super(barcode);
}
