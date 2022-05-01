import 'package:equatable/equatable.dart';

class Barcode extends Equatable {
  const Barcode({
    required final String content,
  }) : _content = content;

  final String _content;

  String get content => _content;

  @override
  List<Object?> get props => [_content];
}
