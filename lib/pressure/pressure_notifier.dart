import 'dart:collection';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/pressure/pressure_item.dart';
import 'package:uuid/uuid.dart';
import '../repository/pressure_item_repository.dart';
import '../repository/pressure_item_repository_pref.dart';

class PressureNotifier
    extends StateNotifier<Map<DateTime, List<PressureItem>>> {
  PressureNotifier() : super({});

  final PressureItemRepository pressureItemRepository =
      PressureItemRepositoryPref();

  Future<void> initialize() async {
    final newMap = await pressureItemRepository.getPressureItemMap();
    state =  {...newMap};
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
    state = {..._sortMap(state)};
    // データの永続化
    pressureItemRepository.setPressureItemMap(state);
  }

  Map<DateTime, List<PressureItem>> _sortMap(
      Map<DateTime, List<PressureItem>> map) {
    return SplayTreeMap.from(map, (a, b) => a.compareTo(b));
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
    // データの永続化
    pressureItemRepository.setPressureItemMap(state);
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
    // データの永続化
    pressureItemRepository.setPressureItemMap(state);
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
  void testRandomAdd(DateTime dateTime) {
    var rng = Random();
    final pressureItem = PressureItem(
        // generate random number from 80 to 160
        maxPressure: rng.nextInt(80) + 80,
        minPressure: rng.nextInt(60) + 40,
        pulse: rng.nextInt(50) + 50,
        uuid: const Uuid().v4(),
        measurementTime: DateTime.now());
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
    state = {..._sortMap(state)};
    // データの永続化
    pressureItemRepository.setPressureItemMap(state);
  }

  @visibleForTesting
  void permanentlyShowCondition() {
    print(pressureItemRepository.getPressureItemMap());
  }

  @visibleForTesting
  void testClearAll() {
    state = {};
    pressureItemRepository.setPressureItemMap(state);
  }
}
