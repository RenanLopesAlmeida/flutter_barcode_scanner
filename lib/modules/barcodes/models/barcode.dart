import 'package:freezed_annotation/freezed_annotation.dart';

part 'barcode.freezed.dart';

@freezed
class Barcode with _$Barcode {
  const factory Barcode({
    required final String content,
    @Default(false) final bool isContentUrl,
  }) = _Barcode;
}
