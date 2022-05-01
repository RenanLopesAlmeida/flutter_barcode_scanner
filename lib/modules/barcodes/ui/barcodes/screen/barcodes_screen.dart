import 'package:barcodes_flutter_app/widgets/modal_bottom_sheet_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:barcodes_flutter_app/core/typedefs/scan_option.dart';
import 'package:barcodes_flutter_app/modules/barcodes/cubits/barcodes_cubit.dart';
import 'package:barcodes_flutter_app/modules/barcodes/models/barcode.dart';

part '../widgets/barcode_item.dart';

class BarcodesListScreen extends StatelessWidget {
  const BarcodesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcodes List'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scanBarCode(context),
        child: const Icon(Icons.qr_code),
      ),
      body: BlocBuilder<BarcodesCubit, List<Barcode>>(
        builder: (context, barcodes) {
          final orderedBarcodes = barcodes.reversed.toList();

          return (orderedBarcodes.isEmpty)
              ? const Center(
                  child: Text('Nothing Here...'),
                )
              : Container(
                  margin: const EdgeInsetsDirectional.only(
                    start: 20,
                    end: 20,
                  ),
                  child: ListView.builder(
                    itemCount: orderedBarcodes.length,
                    itemBuilder: (final _, final index) {
                      final barcode = orderedBarcodes[index];

                      return _BarcodeItem(
                        barcode: barcode,
                        onDelete: () => _showConfirmationDialog(
                          context: context,
                          barcode: barcode,
                        ),
                        cardPadding: const EdgeInsetsDirectional.all(18),
                        margin: const EdgeInsetsDirectional.only(
                          top: 10,
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }

  Future<void> _scanBarCode(BuildContext context) async {
    final barcode = await context.read<BarcodesCubit>().scanBarCode(
          ScanOption.BARCODE,
        );

    if (barcode == null) {
      return;
    }

    if (barcode.isContentUrl) {
      WidgetsBinding.instance?.addPostFrameCallback(
        (_) => _showBottomSheet(
          context: context,
          url: barcode.content,
        ),
      );
    }
  }

  void _showBottomSheet({
    required final BuildContext context,
    required final String url,
  }) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      builder: (final _) {
        return ModalBottomSheetContent(
          padding: const EdgeInsetsDirectional.only(
            top: 12,
          ),
          title: 'Do you want to go to this website?',
          subtitle: url,
          cancelButtonText: 'Close',
          confirmButtonText: 'Open browser',
          onConfirm: () => _redirectToURL(context: context, url: url),
          onCancel: () => _goBack(context),
        );
      },
    );
  }

  Future<void> _redirectToURL({
    required final BuildContext context,
    required final String url,
  }) async {
    await context.read<BarcodesCubit>().launchURL(url);

    if (Navigator.canPop(context)) {
      _goBack(context);
    }
  }

  void _goBack(final BuildContext context) {
    Navigator.pop(context);
  }

  void _showConfirmationDialog({
    required final BuildContext context,
    required final Barcode barcode,
  }) {
    showDialog(
      context: context,
      builder: (final _) {
        return AlertDialog(
          title: const Text("Do you want to delete this barcode?"),
          content: Text(barcode.content),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _removeBarcode(
                  context: context,
                  barcode: barcode,
                );

                _goBack(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: const Text('Confirm'),
            ),
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _removeBarcode({
    required final BuildContext context,
    required final Barcode barcode,
  }) {
    context.read<BarcodesCubit>().removeBarcode(barcode);
  }
}
