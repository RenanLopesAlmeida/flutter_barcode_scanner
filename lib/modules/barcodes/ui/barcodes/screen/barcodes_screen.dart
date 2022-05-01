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
          return (barcodes.isEmpty)
              ? const Center(
                  child: Text('Nothing Here...'),
                )
              : Container(
                  margin: const EdgeInsetsDirectional.only(
                    start: 20,
                    end: 20,
                  ),
                  child: ListView.builder(
                    itemCount: barcodes.length,
                    itemBuilder: (final _, final index) {
                      final barcode = barcodes[index];

                      return _BarcodeItem(
                        barcode: barcode,
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
      builder: (BuildContext context) {
        return ModalBottomSheetContent(
          padding: const EdgeInsetsDirectional.only(
            top: 12,
          ),
          title: 'Do you want to go to this website?',
          subtitle: url,
          cancelButtonText: 'Close',
          confirmButtonText: 'Open browser',
          onConfirm: () => _redirectToURL(url),
          onCancel: () => _goBack(context),
        );
      },
    );
  }

  void _redirectToURL(final String url) {}

  void _goBack(final BuildContext context) {}
}
