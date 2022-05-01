part of '../screen/barcodes_screen.dart';

class _BarcodeItem extends StatelessWidget {
  const _BarcodeItem({
    required final Barcode barcode,
    required final VoidCallback onDelete,
    final EdgeInsetsGeometry? cardPadding,
    final EdgeInsetsGeometry? margin,
    final Key? key,
  })  : _barcode = barcode,
        _onDelete = onDelete,
        _cardPadding = cardPadding,
        _margin = margin,
        super(key: key);

  final Barcode _barcode;
  final VoidCallback _onDelete;
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  _barcode.content,
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: _onDelete,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
