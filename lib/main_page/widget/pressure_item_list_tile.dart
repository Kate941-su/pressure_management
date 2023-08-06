import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/datetime/datetime_provider.dart';

import '../../pressure/pressure_provider.dart';
import '../../util/util.dart';

class PressureItemListTile extends ConsumerWidget {
  PressureItemListTile(
      {required this.maxPressure,
      required this.minPressure,
      required this.pulse,
      required this.uuid,
      required this.measurementTime,
      super.key});

  final int maxPressure;
  final int minPressure;
  final int pulse;
  final String uuid;
  final DateTime measurementTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectDayProvider);
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          measurementTime.hour > 3 && measurementTime.hour < 15
              ? const Icon(Icons.sunny)
              : const Icon(Icons.nightlight),
          Text(Util.getPrettyTime(measurementTime)),
        ],
      ),
      title: Column(
        children: [
          Text('血圧 : ${maxPressure.toString()}/${minPressure.toString()}'),
          Text('脈拍 : ${pulse.toString()}'),
//          Text('uuid : $uuid'),
        ],
      ),
      trailing: FractionallySizedBox(
        widthFactor: 0.25,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.restore_from_trash_rounded,
              ),
              constraints: const BoxConstraints(),
              onPressed: () {
                ref.read(pressureProvider.notifier).delete(selectedDay, uuid);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.edit,
              ),
              constraints: const BoxConstraints(),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
