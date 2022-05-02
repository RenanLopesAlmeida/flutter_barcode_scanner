import 'package:barcodes_flutter_app/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:barcodes_flutter_app/core/service_locator/service_locator_config.dart';
import 'package:barcodes_flutter_app/modules/barcodes/cubits/barcode_picker_cubit.dart';
import 'package:barcodes_flutter_app/modules/barcodes/cubits/barcode_state_cubit.dart';
import 'package:barcodes_flutter_app/modules/barcodes/cubits/barcodes_cubit.dart';
import 'package:barcodes_flutter_app/modules/barcodes/ui/barcodes/screen/barcodes_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocatorConfig.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Scanner',
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.getDefaultTheme(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<BarcodesCubit>.value(
            value: BarcodesCubit(
              redirectLauncher: ServiceLocatorConfig.provide(),
              scanBarCodeInputPort: ServiceLocatorConfig.provide(),
            ),
            child: const BarcodesListScreen(),
          ),
          BlocProvider<BarcodeStateCubit>.value(
            value: BarcodeStateCubit(),
            child: const BarcodesListScreen(),
          ),
          BlocProvider<BarcodePickerCubit>.value(
            value: BarcodePickerCubit(),
            child: const BarcodesListScreen(),
          ),
        ],
        child: const BarcodesListScreen(),
      ),
    );
  }
}
