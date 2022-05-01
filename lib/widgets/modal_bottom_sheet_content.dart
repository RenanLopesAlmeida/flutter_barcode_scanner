import 'package:flutter/material.dart';

class ModalBottomSheetContent extends StatelessWidget {
  const ModalBottomSheetContent({
    required final String title,
    required final String confirmButtonText,
    required final String cancelButtonText,
    required final VoidCallback onConfirm,
    required final VoidCallback onCancel,
    final EdgeInsetsGeometry? padding,
    final String? subtitle,
    final Key? key,
  })  : _padding = padding,
        _title = title,
        _confirmButtonText = confirmButtonText,
        _cancelButtonText = cancelButtonText,
        _subtitle = subtitle,
        _onConfirm = onConfirm,
        _onCancel = onCancel,
        super(key: key);

  final String _title;
  final String _confirmButtonText;
  final String _cancelButtonText;
  final String? _subtitle;
  final VoidCallback _onConfirm;
  final VoidCallback _onCancel;
  final EdgeInsetsGeometry? _padding;

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
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      if (_subtitle != null)
                        Text(
                          _subtitle ?? '',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      const Spacer(),
                      ElevatedButton(
                        child: Text(_confirmButtonText),
                        onPressed: _onConfirm,
                      ),
                      TextButton(
                        child: Text(_cancelButtonText),
                        onPressed: _onCancel,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
