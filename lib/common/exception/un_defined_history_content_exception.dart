class UnDefinedHistoryKindException implements Exception {
  final String message;

  UnDefinedHistoryKindException(this.message);

  @override
  String toString() => 'UnDefinedHistoryContentException: $message';
}