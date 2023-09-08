sealed class PatchException implements Exception {
  @override
  String toString() {
    return 'PatchRepoException';
  }
}

class PatchNetworkException extends PatchException {
  @override
  String toString() {
    return 'PatchNetworkException';
  }
}

class PatchUnsupportedFormat extends PatchException {
  @override
  String toString() {
    return  'PatchUnsupportedFormat';
  }
}
