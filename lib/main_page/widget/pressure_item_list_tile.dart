import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/datetime/datetime_provider.dart';

import '../../pressure/pressure_provider.dart';

class PressureItemListTile extends ConsumerWidget {
  PressureItemListTile(
      {required this.maxPressure,
      required this.minPressure,
      required this.pulse,
      required this.uuid,
      super.key});

  final int maxPressure;
  final int minPressure;
  final int pulse;
  final String uuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectDayProvider);
    return ListTile(
      title: Column(
        children: [
          Text('max pressure : ${maxPressure.toString()}'),
          Text('min pressure : ${minPressure.toString()}'),
          Text('pulse : ${pulse.toString()}'),
          Text('uuid : $uuid'),
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
