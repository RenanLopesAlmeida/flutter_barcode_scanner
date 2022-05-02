import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodePickerCubit extends Cubit<int> {
  BarcodePickerCubit() : super(0);

  void setValue(int? value) {
    emit(value ?? 0);
  }
}
