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
              : ListView.builder(
                  itemCount: barcodes.length,
                  itemBuilder: (final _, final index) {
                    final barcode = barcodes[index];

                    return _BarcodeItem(
                      barcode: barcode,
                      cardPadding: const EdgeInsetsDirectional.all(18),
                    );
                  },
                );
        },
      ),
    );
  }

  void _scanBarCode(BuildContext context) {
    context.read<BarcodesCubit>().scanBarCode(ScanOption.BARCODE);
  }
}
