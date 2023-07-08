import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/pressure/pressure_item.dart';

class PressureNotifier
    extends StateNotifier<Map<DateTime, List<PressureItem>>> {
  PressureNotifier() : super({});

  void add(DateTime dateTime, PressureItem pressureItem) {
    if (state.isNotEmpty) {
      state.forEach((key, value) {
        if (key == dateTime) {
          state[key] = [...?state[key], pressureItem];
        } else {
          state[key] = [pressureItem];
        }
      });
    }
  }
}
