class Flavor {
  static get isRelease => const bool.fromEnvironment('dart.vm.product');
}