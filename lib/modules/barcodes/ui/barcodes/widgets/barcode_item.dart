part of '../screen/barcodes_screen.dart';

class _BarcodeItem extends StatelessWidget {
  const _BarcodeItem({
    required final Barcode barcode,
    final EdgeInsetsGeometry? cardPadding,
    final EdgeInsetsGeometry? margin,
    final Key? key,
  })  : _barcode = barcode,
        _cardPadding = cardPadding,
        _margin = margin,
        super(key: key);

  final Barcode _barcode;
  final EdgeInsetsGeometry? _cardPadding;
  final EdgeInsetsGeometry? _margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          margin: _cardPadding,
          child: Text(
            _barcode.content,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
