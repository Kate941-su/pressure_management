import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_training/pressure/pressure_item.dart';
import 'package:flutter_training/pressure/pressure_notifier.dart';

final pressureProvider =
    StateNotifierProvider<PressureNotifier, Map<DateTime, List<PressureItem>>>((ref) {
  return PressureNotifier();
});
