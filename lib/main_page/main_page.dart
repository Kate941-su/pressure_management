import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/datetime/datetime_provider.dart';
import 'package:flutter_training/main_page/calendar_item.dart';
import 'package:flutter_training/main_page/widget/day_part.dart';
import 'package:flutter_training/main_page/widget/pressure_item_list_tile.dart';
import 'package:flutter_training/pressure/pressure_provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../pressure/bottom_navigation_bar_index_provider.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectDayProvider);
    final focusedDay = ref.watch(focusDayProvider);
    final pressureItemMap = ref.watch(pressureProvider);
    final bottomNavigationBarSelectedIndex =
        ref.watch(bottomNavigationBarIndexProvider);
    final hasSelected = ref.watch(hasSelectedProvider);
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                ref.read(pressureProvider.notifier).testRandomAdd(
                      selectedDay,
                    );
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
            IconButton(
              onPressed: () {
                ref.read(pressureProvider.notifier).permanentlyShowCondition();
              },
              icon: const Icon(Icons.safety_check_sharp),
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
            },
            rangeSelectionMode: bottomNavigationBarSelectedIndex ==
                    BottomNavigationBarIndexItem.dialog
                ? RangeSelectionMode.toggledOn
                : RangeSelectionMode.toggledOff,
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
              if (!hasSelected) {
                ref.read(hasSelectedProvider.notifier).state = true;
              }
            }),
        Visibility(
          child: const DayPart(),
          visible: hasSelected,
        ),
        Visibility(
          child: const Text('測定結果を追加するには日付を選択してください！'),
          visible: !hasSelected,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: pressureItemMap[selectedDay]?.length,
            itemBuilder: (context, index) {
              // you can identify unique item
              final pressureItem = pressureItemMap[selectedDay]?[index];
              return pressureItem != null
                  ? Card(
                      child: PressureItemListTile(
                        maxPressure: pressureItem.maxPressure!,
                        minPressure: pressureItem.minPressure!,
                        pulse: pressureItem.pulse!,
                        uuid: pressureItem.uuid!,
                        measurementTime: pressureItem.measurementTime!,
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
