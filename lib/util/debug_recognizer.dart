class DebugRecognizer {
  static final shared = DebugRecognizer();
  static const isRelease = bool.fromEnvironment('dart.vm.product');
}