import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/datetime/datetime_provider.dart';

class DayPart extends ConsumerWidget {
  const DayPart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectDayProvider);
    return Text(
      '${selectedDay.year}年${selectedDay.month}月${selectedDay.day}日',
      style: const TextStyle(
        fontSize: 32,
      ),
    );
  }
}
