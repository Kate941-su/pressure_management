import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/datetime/datetime_provider.dart';
import 'package:flutter_training/main_page/calendar_item.dart';
import 'package:table_calendar/table_calendar.dart';
import '../pressure/mocked_pressure_items_map.dart';

class MainPage extends ConsumerWidget {
  MainPage({super.key});

  // has a state
  final sampleEvents = {
    DateTime.utc(2023, 8, 7): ['firstEvent', 'secondEvent'],
    DateTime.utc(2023, 8, 5): ['thirdEvent', 'fourthEvent']
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
              return mockedPressureItemsMap[date] ?? [];
            },
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => day == focusedDay,
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: focusedDay,
            shouldFillViewport: false,
            locale: 'ja_JP',
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            onDaySelected: (selectDay, focusDay) {
              ref.read(selectDayProvider.notifier).setDatetime(selectDay);
              ref.read(focusDayProvider.notifier).setDatetime(selectDay);
            }),
        Expanded(
          child: ListView.builder(
            itemCount: mockedPressureItemsMap[selectedDay]?.length,
            itemBuilder: (context, index) {
              final pressureItem = mockedPressureItemsMap[selectedDay]?[index];
              return pressureItem != null
                  ? Card(
                      child: ListTile(
                        title: Column(
                          children: [
                            Text(pressureItem.maxPressure.toString()),
                            Text(pressureItem.minPressure.toString()),
                            Text(pressureItem.pulse.toString()),
                          ],
                        ),
                      ),
                    )
                  : null;
            },
          ),
        ),
      ],
    );
  }
}
