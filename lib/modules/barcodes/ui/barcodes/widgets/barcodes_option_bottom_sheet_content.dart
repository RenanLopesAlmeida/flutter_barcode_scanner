part of '../screen/barcodes_screen.dart';

class _BarcodesPickerBottomSheetContent extends StatelessWidget {
  const _BarcodesPickerBottomSheetContent({
    required final String title,
    required final String confirmButtonText,
    required final String cancelButtonText,
    required final VoidCallback onConfirm,
    required final VoidCallback onCancel,
    required final List<Barcode> barcodes,
    required final groupValue,
    required final ValueChanged<int?> onChanged,
    final EdgeInsetsGeometry? padding,
    final String? subtitle,
    final Key? key,
  })  : _padding = padding,
        _barcodes = barcodes,
        _groupValue = groupValue,
        _title = title,
        _confirmButtonText = confirmButtonText,
        _cancelButtonText = cancelButtonText,
        _subtitle = subtitle,
        _onConfirm = onConfirm,
        _onCancel = onCancel,
        _onChanged = onChanged,
        super(key: key);

  final String _title;
  final String _confirmButtonText;
  final String _cancelButtonText;
  final String? _subtitle;
  final VoidCallback _onConfirm;
  final VoidCallback _onCancel;
  final EdgeInsetsGeometry? _padding;
  final List<Barcode> _barcodes;
  final int _groupValue;
  final ValueChanged<int?> _onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            _title,
            style: Theme.of(context).textTheme.headline5?.copyWith(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Column(
              children: [
                if (_subtitle != null)
                  Text(
                    _subtitle ?? '',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                    textAlign: TextAlign.center,
                  ),
                Flexible(
                  child: ListView.builder(
                    itemCount: _barcodes.length,
                    itemBuilder: (final _, final index) {
                      final barcode = _barcodes[index];

                      return ListTile(
                        title: Text(barcode.content),
                        trailing: Radio(
                          groupValue: _groupValue,
                          onChanged: _onChanged,
                          value: index,
                        ),
                      );
                    },
                  ),
                ),
                //const Spacer(),
                ElevatedButton(
                  child: Text(_confirmButtonText),
                  onPressed: _onConfirm,
                ),
                TextButton(
                  child: Text(_cancelButtonText),
                  onPressed: _onCancel,
                ),

                const SizedBox(height: 5),
              ],
            ),
          )
        ],
      ),
    );
  }
}
