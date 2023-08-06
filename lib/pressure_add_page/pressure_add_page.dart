import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_training/datetime/datetime_provider.dart';
import 'package:flutter_training/pressure/pressure_item.dart';
import 'package:flutter_training/pressure/pressure_provider.dart';
import 'package:flutter_training/pressure_add_page/pressure_add_view_model.dart';
import 'package:flutter_training/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:uuid/uuid.dart';

import '../main_page/widget/day_part.dart';

DateTime? _dateTime = DateTime.now();

class PressureAddPage extends HookConsumerWidget {
  PressureAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxPressureTextController = useTextEditingController();
    final minPressureTextController = useTextEditingController();
    final pulseTextController = useTextEditingController();
    final selectedDay = ref.watch(selectDayProvider);
    useEffect(() {
      return null;
    }, [
      maxPressureTextController,
      minPressureTextController,
      pulseTextController
    ]);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DayPart(),
          _PressureAddTextFiled(
            itemName: '最高血圧',
            controller: maxPressureTextController,
          ),
          _PressureAddTextFiled(
            itemName: '最低血圧',
            controller: minPressureTextController,
          ),
          _PressureAddTextFiled(
            itemName: '脈拍',
            controller: pulseTextController,
          ),
          _PressureAddTickFiled(itemName: '測定時刻'),
          Container(
              margin: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(color: Colors.blueAccent),
              child: TextButton(
                  onPressed: () async {
                    if (maxPressureTextController.text.isEmpty ||
                        minPressureTextController.text.isEmpty ||
                        pulseTextController.text.isEmpty) {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const Dialog(
                              child: Text('全てのアイテムを入力してください'),
                            );
                          });
                    } else {
                      ref.read(pressureProvider.notifier).add(
                          dateTime: selectedDay,
                          pressureItem: PressureItem(
                              uuid: const Uuid().v4(),
                              maxPressure:
                                  int.parse(maxPressureTextController.text),
                              minPressure:
                                  int.parse(minPressureTextController.text),
                              pulse: int.parse(pulseTextController.text),
                              measurementTime: PressureAddViewModel(ref: ref).getTime()));
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const Dialog(
                              child: Text('you put item'),
                            );
                          });
                    }
                  },
                  child: const Text(
                    '登録',
                    style: TextStyle(color: Colors.white),
                  ))),
        ],
      ),
    );
  }
}

class _PressureAddTextFiled extends HookConsumerWidget {
  _PressureAddTextFiled(
      {required this.itemName, required this.controller, super.key});

  final String itemName;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(width: 125, child: Text('$itemName : ')),
          SizedBox(
              width: 250,
              child: TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: controller,
                decoration: InputDecoration(
                  labelText: '$itemName',
                  errorText: null,
                ),
              )),
        ],
      ),
    );
  }
}

class _PressureAddTickFiled extends HookConsumerWidget {
  _PressureAddTickFiled({required this.itemName, super.key});

  final String itemName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pressureAddViewModel = PressureAddViewModel(ref: ref);
    final measurementTime = ref.watch(measurementTimeProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(width: 125, child: Text('$itemName : ')),
          TextButton(
            onPressed: () async {
              await pressureAddViewModel.onPressedInputTime(context);
            },
            child: Text('時刻入力'),
          ),
          Text(Util.getPrettyTime(measurementTime))
        ],
      ),
    );
  }
}
