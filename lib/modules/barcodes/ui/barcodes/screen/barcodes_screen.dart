import 'package:barcodes_flutter_app/extensions/string_extension.dart';
import 'package:barcodes_flutter_app/modules/barcodes/cubits/barcode_picker_cubit.dart';
import 'package:barcodes_flutter_app/modules/barcodes/cubits/barcode_state.dart';
import 'package:barcodes_flutter_app/modules/barcodes/cubits/barcode_state_cubit.dart';
import 'package:barcodes_flutter_app/widgets/alert_dialog_content.dart';
import 'package:barcodes_flutter_app/widgets/modal_bottom_sheet_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:barcodes_flutter_app/core/typedefs/scan_option.dart';
import 'package:barcodes_flutter_app/modules/barcodes/cubits/barcodes_cubit.dart';
import 'package:barcodes_flutter_app/modules/barcodes/models/barcode.dart';

part '../widgets/barcode_item.dart';
part '../widgets/barcodes_option_bottom_sheet_content.dart';

class BarcodesListScreen extends StatelessWidget {
  const BarcodesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcodes Scanner'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scanBarCode(context),
        child: const Icon(Icons.qr_code),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocListener<BarcodeStateCubit, BarcodeContent>(
            listener: (_, state) {
              if (state is BarcodeMultipleContent) {
                final barcodes =
                    context.read<BarcodesCubit>().extractContentByDelimiter(
                          barcode: state.barcode,
                        );

                WidgetsBinding.instance?.addPostFrameCallback(
                  (_) => _showMultipleContentsBottomSheet(
                    context: context,
                    barcodes: barcodes,
                  ),
                );
              }

              if (state is BarcodeURLState) {
                final barcode = state.barcode;

                WidgetsBinding.instance?.addPostFrameCallback(
                  (_) => _showUrlLauncherBottomSheet(
                    context: context,
                    url: barcode.content,
                  ),
                );
              }
            },
            child: const SizedBox(),
          ),
          Expanded(
            child: BlocBuilder<BarcodesCubit, List<Barcode>>(
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
          ),
        ],
      ),
    );
  }

  Future<void> _scanBarCode(BuildContext context) async {
    final barcode = await context.read<BarcodesCubit>().scanBarCode(
          ScanOption.QR,
        );

    if (barcode == null) {
      return;
    }

    if (barcode.hasMultipleContents) {
      context.read<BarcodeStateCubit>().setMultipleContent(barcode);
      return;
    }

    if (barcode.isContentUrl) {
      WidgetsBinding.instance?.addPostFrameCallback(
        (_) => _showUrlLauncherBottomSheet(
          context: context,
          url: barcode.content,
        ),
      );
    }
  }

  void _showUrlLauncherBottomSheet({
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
        return AlertDialogContent(
          title: 'Do you want to delete this barcode?',
          content: barcode.content,
          confirmButtonTitle: 'Confirm',
          cancelButtonTitle: 'Close',
          confirmButtonStyle: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          onCancel: () => _goBack(context),
          onConfirm: () {
            _removeBarcode(
              context: context,
              barcode: barcode,
            );

            _goBack(context);
          },
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

  void _showMultipleContentsBottomSheet({
    required final BuildContext context,
    required final List<Barcode> barcodes,
  }) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      builder: (final _) {
        return BlocBuilder<BarcodePickerCubit, int>(
          bloc: BlocProvider.of<BarcodePickerCubit>(context),
          builder: (final _, final index) {
            return _BarcodesPickerBottomSheetContent(
              padding: const EdgeInsetsDirectional.only(
                top: 12,
              ),
              barcodes: barcodes,
              title: 'Pick the content that you want',
              cancelButtonText: 'Cancel',
              confirmButtonText: 'Confirm',
              onConfirm: () => _addBarcode(
                context: context,
                barcode: barcodes[index],
              ),
              onCancel: () => _goBack(context),
              groupValue: index,
              onChanged: context.read<BarcodePickerCubit>().setValue,
            );
          },
        );
      },
    );
  }

  void _addBarcode({
    required final BuildContext context,
    required final Barcode barcode,
  }) {
    context.read<BarcodesCubit>().addBarcode(barcode);
    _goBack(context);

    final hasURL = barcode.content.isURL;

    if (hasURL) {
      context.read<BarcodeStateCubit>().setBarcodeURLState(barcode);
    }
  }
}
