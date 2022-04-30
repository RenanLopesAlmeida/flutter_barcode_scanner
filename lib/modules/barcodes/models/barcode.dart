import 'package:equatable/equatable.dart';

class Barcode extends Equatable {
  const Barcode({required final this.content});
  final String content;

  @override
  List<Object?> get props => [content];
}
