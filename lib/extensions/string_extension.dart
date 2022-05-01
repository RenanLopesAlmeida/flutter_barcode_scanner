extension StringExtension on String {
  bool get isURL {
    final content = this;

    final Uri? uri = Uri.tryParse(content);

    return uri?.hasAbsolutePath ?? false;
  }
}
