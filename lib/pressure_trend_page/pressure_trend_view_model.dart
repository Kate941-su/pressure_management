import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/pressure/pressure_provider.dart';
import '../datetime/datetime_provider.dart';

import '../pressure/pressure_item.dart';

class PressureTrendViewModel {
  PressureTrendViewModel({
    required this.ref,
    required this.context,
  });

  final WidgetRef ref;
  final BuildContext context;

  //  日付(レンジ)選択
  Future openDateRange(BuildContext context) async {
    //  （2） showDateRangePickerを使う
    final startDay = ref.watch(startDayProvider);
    final endDay = ref.watch(endDayProvider);
    final DateTimeRange? range = await showDateRangePicker(
      context: context,
      // （3） 初期の日付期間を指定する
      initialDateRange: DateTimeRange(start: startDay, end: endDay),
      firstDate: DateTime.utc(2000, 1, 1),
      lastDate: DateTime.utc(2030, 12, 31),
    );
    if (range != null) {
      ref.read(startDayProvider.notifier).setDatetime(range.start.toUtc());
      ref.read(endDayProvider.notifier).setDatetime(range.end.toUtc());
    }
  }

  @visibleForTesting
  Map<DateTime, List<PressureItem>> getPressureMapWithRange(
      {required DateTime startDay,
        required DateTime endDay}) {
    final pressureItemMap = ref.watch(pressureProvider);
    if (pressureItemMap != null) {
      List<MapEntry<DateTime, List<PressureItem>>> tempList =
      pressureItemMap.entries.where((entry) {
        final isInRange =
            entry.key.isAfter(startDay.subtract(const Duration(days: 1))) &&
                entry.key.isBefore(endDay.add(const Duration(days: 1)));
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

  PressureItem getPressureItemAverageWithRange(
      {required DateTime startDay, required DateTime endDay}) {
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
    if (itemCount != 0) {
      return PressureItem(
        maxPressure: sumMaxPressure ~/ itemCount,
        minPressure: sumMinPressure ~/ itemCount,
        pulse: sumPulse ~/ itemCount,
      );
    } else {
      return const PressureItem();
    }
  }

  Map<DateTime, PressureItem> getPressureItemMapAveragePerDayWithRange(
      {required DateTime startDay, required DateTime endDay}) {
    final map = getPressureMapWithRange(startDay: startDay, endDay: endDay);
    Map<DateTime, PressureItem> newMap = {};
    for (var key in map.keys) {
      var itemCountPerDay = 0;
      var sumMaxPressurePerDay = 0;
      var sumMinPressurePerDay = 0;
      var sumPulsePerDay = 0;
      for (var pressureItem in map[key]!) {
        itemCountPerDay += 1;
        sumMaxPressurePerDay += pressureItem.maxPressure!;
        sumMinPressurePerDay += pressureItem.minPressure!;
        sumPulsePerDay += pressureItem.pulse!;
      }
      if (itemCountPerDay != 0) {
        newMap.addAll({
          key: PressureItem(
              maxPressure: sumMaxPressurePerDay ~/ itemCountPerDay,
              minPressure: sumMinPressurePerDay ~/ itemCountPerDay,
              pulse: sumPulsePerDay ~/ itemCountPerDay)
        });
      }
    }
    return newMap;
  }

}
