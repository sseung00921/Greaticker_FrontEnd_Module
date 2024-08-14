class UnListedStickerNumberException implements Exception {
  final String message;

  UnListedStickerNumberException(this.message);

  @override
  String toString() => 'UnListedStickerNumberException: $message';
}