import 'package:flutter/material.dart';

class AlertDialogContent extends StatelessWidget {
  const AlertDialogContent({
    required final String title,
    required final String content,
    required final String confirmButtonTitle,
    required final String cancelButtonTitle,
    required final VoidCallback onConfirm,
    required final VoidCallback onCancel,
    final ButtonStyle? confirmButtonStyle,
    Key? key,
  })  : _title = title,
        _content = content,
        _confirmButtonTitle = confirmButtonTitle,
        _cancelButtonTitle = cancelButtonTitle,
        _onConfirm = onConfirm,
        _onCancel = onCancel,
        _confirmButtonStyle = confirmButtonStyle,
        super(key: key);

  final String _title;
  final String _content;
  final String _confirmButtonTitle;
  final String _cancelButtonTitle;

  final VoidCallback _onConfirm;
  final VoidCallback _onCancel;

  final ButtonStyle? _confirmButtonStyle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title),
      content: Text(_content),
      actions: <Widget>[
        ElevatedButton(
          onPressed: _onConfirm,
          style: _confirmButtonStyle,
          child: Text(_confirmButtonTitle),
        ),
        TextButton(
          child: Text(_cancelButtonTitle),
          onPressed: _onCancel,
        ),
      ],
    );
  }
}
