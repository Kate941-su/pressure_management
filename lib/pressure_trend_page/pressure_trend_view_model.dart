import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datetime/datetime_provider.dart';

import '../datetime/datetime_provider.dart';

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
}
