import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../datetime/datetime_provider.dart';

class CalendarItem extends ConsumerWidget {
  const CalendarItem({
    required this.day,
    super.key,
  });

  final DateTime day;

  Color getWeekdayTextColor() {
    if (day.weekday == DateTime.saturday) {
      return Colors.blue;
    } else if (day.weekday == DateTime.sunday) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectDayProvider);
    final focusedDay = ref.watch(focusDayProvider);
    final text = DateFormat.E('ja').format(day);
    return Center(
      child: Text(
        text,
        style: TextStyle(color: getWeekdayTextColor()),
      ),
    );
  }
}
