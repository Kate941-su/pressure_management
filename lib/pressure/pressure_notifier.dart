import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/pressure/pressure_item.dart';
import 'package:uuid/uuid.dart';

class PressureNotifier
    extends StateNotifier<Map<DateTime, List<PressureItem>>> {
  PressureNotifier() : super({});

  @visibleForTesting
  Map<DateTime, List<PressureItem>> getPressureMapWithRange(
      {required DateTime startDay, required DateTime endDay}) {
    if (state != null) {
      List<MapEntry<DateTime, List<PressureItem>>> tempList = state.entries.where(
              (entry) {
                final isInRange = entry.key.isAfter(startDay.subtract(const Duration(days: 1))) && entry.key.isBefore(endDay.add(const Duration(days: 1)));
                print(isInRange);
                return isInRange;
              }).toList();
      Map<DateTime, List<PressureItem>> retMap = {};
      for (int i = 0; i < tempList.length; i++) {
        retMap[tempList[i].key] = tempList[i].value;
      }
      return retMap;
    } else {
      return {};
    }
    // create Map from eterable
  }

  PressureItem getPressureItemAverageWithRange({required DateTime startDay, required DateTime endDay}) {
    final map = getPressureMapWithRange(startDay: startDay, endDay: endDay);
    var itemCount = 0;
    var sumMaxPressure = 0;
    var sumMinPressure = 0;
    var sumPulse = 0;
    for (var key in map.keys) {
      for (var pressureItem in map[key]!) {
        itemCount += 1;
        sumMaxPressure += pressureItem.maxPressure!;
        sumMinPressure += pressureItem.minPressure!;
        sumPulse += pressureItem.pulse!;
      }
    }
    return PressureItem(
      maxPressure: sumMaxPressure ~/ itemCount,
      minPressure: sumMinPressure ~/ itemCount,
      pulse: sumPulse ~/ itemCount,
    );
  }

  void add({required DateTime dateTime, required PressureItem pressureItem}) {
    if (state.isNotEmpty) {
      bool isBreak = false;
      for (var key in state.keys) {
        if (key == dateTime) {
          state[key] = [...state[key]!, pressureItem];
          isBreak = true;
          break;
        }
      }
      if (!isBreak) {
        state[dateTime] = [pressureItem];
      }
      // deep copy
      state = {...state};
    } else {
      state = {
        dateTime: [pressureItem]
      };
    }
  }

  void delete(DateTime dateTime, String uuid) {
    for (var key in state.keys) {
      if (key == dateTime && state[key]!.isNotEmpty) {
        // retrieve PressureItemElement from List and compare uuid
        // 'where' keyword returns Iterable object.
        state[key] =
            state[key]!.where((PressureItem it) => it.uuid != uuid).toList();
        break;
      }
    }
    // deep copy to reload configuration
    state = {...state};
  }

  void clear(DateTime dateTime) {
    if (state == null) {
      return;
    } else if (state[dateTime] == null) {
      return;
    }
    if (state[dateTime]!.isNotEmpty) {
      state[dateTime] = [];
    }
    state = {...state};
  }

  @visibleForTesting
  void testAdd(DateTime dateTime, PressureItem pressureItem) {
    if (state.isNotEmpty) {
      bool isBreak = false;
      for (var key in state.keys) {
        if (key == dateTime) {
          state[key] = [...state[key]!, pressureItem];
          print(state[key]);
          isBreak = true;
          break;
        }
      }
      if (!isBreak) {
        state[dateTime] = [pressureItem];
      }
      // deep copy
      state = {...state};
    } else {
      state = {
        dateTime: [pressureItem]
      };
    }
  }

  @visibleForTesting
  void testClearAll() {
    state = {};
  }
}
