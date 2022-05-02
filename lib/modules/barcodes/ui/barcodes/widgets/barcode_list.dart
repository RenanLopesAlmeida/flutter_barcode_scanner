part of '../screen/barcodes_screen.dart';

class _BarcodeList extends StatelessWidget {
  const _BarcodeList({
    required final List<Barcode> barcodes,
    required final Function(Barcode barcode) onDelete,
    Key? key,
  })  : _barcodes = barcodes,
        _onDelete = onDelete,
        super(key: key);

  final List<Barcode> _barcodes;

  final Function(Barcode barcode) _onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(
        start: 20,
        end: 20,
      ),
      child: ListView.builder(
        itemCount: _barcodes.length,
        itemBuilder: (final _, final index) {
          final barcode = _barcodes[index];

          return _BarcodeItem(
            barcode: barcode,
            onDelete: () => _onDelete(barcode),
            cardPadding: const EdgeInsetsDirectional.all(18),
            margin: const EdgeInsetsDirectional.only(
              top: 10,
            ),
          );
        },
      ),
    );
  }
}
