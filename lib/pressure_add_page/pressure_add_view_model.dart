import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datetime/datetime_provider.dart';

class PressureAddViewModel {
  PressureAddViewModel({
    required this.ref,
  });

  final WidgetRef ref;

  void onTapSubmit({
    required String max,
    required String min,
    required String pulse,
  }) {}

  int _convertTextToInt(String text) {
    int num;
    if (text.isEmpty) {
      return 1;
    }
    try {
      num = int.parse(text);
    } catch (e) {
      print(e);
      return -1;
    }
    return num;
  }

  Future<void> onPressedInputTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
     ref.read(measurementTimeProvider.notifier).state = _toDateTime(time);
    }
  }

  DateTime getTime() {
    return ref.read(measurementTimeProvider.notifier).state;
  }

  _toDateTime(TimeOfDay t) {
    var now = DateTime.now();
    /// TODO 多国籍対応のためには+9の記述を変更する必要あり
    return DateTime(now.year, now.month, now.day, t.hour, t.minute);
  }
}
