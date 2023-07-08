import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/datetime/datetime_provider.dart';
import 'package:flutter_training/main_page/calendar_item.dart';
import 'package:table_calendar/table_calendar.dart';

class MainPage extends ConsumerWidget {
  MainPage({super.key});

  // has a state
  final sampleEvents = {
    DateTime.now(): ['firstEvent', 'secondEvent'],
    DateTime.utc(2023, 7, 5): ['thirdEvent', 'fourthEvent']
  };

  // has a state

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectDayProvider);
    final focusedDay = ref.watch(focusDayProvider);
    return Column(
      children: [
        TableCalendar(
            calendarBuilders: CalendarBuilders(dowBuilder: (context, day) {
              return CalendarItem(day: day);
            }),
            eventLoader: (date) {
              return sampleEvents[date] ?? [];
            },
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => day == focusedDay,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: focusedDay,
            shouldFillViewport: false,
            locale: 'ja_JP',
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            onDaySelected: (selectDay, focusDay) {
              ref.read(focusDayProvider.notifier).setDatetime(selectDay);
            }),
        Expanded(child: Text(
            sampleEvents[selectedDay] != null ? sampleEvents[selectedDay]![0] : ''
        ))
      ],
    );
  }
}
