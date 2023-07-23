import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/datetime/datetime_provider.dart';
import 'package:flutter_training/main_page/calendar_item.dart';
import 'package:flutter_training/pressure/pressure_provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../pressure/pressure_item.dart';


class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectDayProvider);
    final focusedDay = ref.watch(focusDayProvider);
    final pressureItemMap = ref.watch(pressureProvider);
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                ref.read(pressureProvider.notifier).testAdd(
                    selectedDay,
                    const PressureItem(maxPressure: 200, minPressure: 100, pulse: 90));
                print(pressureItemMap);
              },
              icon: const Icon(Icons.add_circle_outline),
            ),
            IconButton(
              onPressed: () {
                print(pressureItemMap);
              },
              icon: const Icon(Icons.remove_red_eye_outlined),
            ),
            IconButton(
              onPressed: () {
                ref.read(pressureProvider.notifier).clear(selectedDay);
              },
              icon: const Icon(Icons.restore_from_trash_outlined),
            ),
            IconButton(
              onPressed: () {
                ref.read(pressureProvider.notifier).testClearAll();
              },
              icon: const Icon(Icons.escalator_warning),
            ),
            Text(pressureItemMap[selectedDay] != null
                ? pressureItemMap[selectedDay]!.length.toString()
                : 'null'),
          ],
        ),
        TableCalendar(
            calendarBuilders: CalendarBuilders(dowBuilder: (context, day) {
              return CalendarItem(day: day);
            }),
            eventLoader: (date) {
              if (pressureItemMap[date] != null) {
                return pressureItemMap[date]!;
              } else {
                return [];
              }
//              return mockedPressureItemsMap[date] ?? [];
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
            itemCount: pressureItemMap[selectedDay]?.length,
            itemBuilder: (context, index) {
              final pressureItem = pressureItemMap[selectedDay]?[index];
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
