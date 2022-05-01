import 'package:barcodes_flutter_app/core/usecases/bar_code_scanner_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:barcodes_flutter_app/core/usecases/scan_barcode_use_case.dart';
import 'package:barcodes_flutter_app/modules/barcodes/cubits/barcodes_cubit.dart';
import 'package:barcodes_flutter_app/modules/barcodes/ui/barcodes/screen/barcodes_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //TODO :: Inject it
      home: MultiBlocProvider(
        providers: [
          BlocProvider<BarcodesCubit>.value(
            value: BarcodesCubit(
              scanBarCodeInputPort: ScanBarcodeUseCase(
                barcodeScannerInputPort: BarcodeScannerUseCase(),
              ),
            ),
            child: const BarcodesListScreen(),
          ),
        ],
        child: const BarcodesListScreen(),
      ),
    );
  }
}
