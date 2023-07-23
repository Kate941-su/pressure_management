import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_training/datetime/datetime_provider.dart';
import 'package:flutter_training/pressure/pressure_item.dart';
import 'package:flutter_training/pressure/pressure_provider.dart';
import 'package:flutter_training/pressure_add_page/pressure_add_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:uuid/uuid.dart';

class PressureAddPage extends HookConsumerWidget {
  PressureAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxPressureTextController = useTextEditingController();
    final minPressureTextController = useTextEditingController();
    final pulseTextController = useTextEditingController();
    final pressureAddViewModel = PressureAddViewModel(ref: ref);
    final selectedDay = ref.watch(selectDayProvider);
    useEffect(() {}, [
      maxPressureTextController,
      minPressureTextController,
      pulseTextController
    ]);
    return Scaffold(
      body: Column(
        children: [
          _PressureAddTextFiled(
            itemName: 'max pressure',
            controller: maxPressureTextController,
          ),
          _PressureAddTextFiled(
            itemName: 'min pressure',
            controller: minPressureTextController,
          ),
          _PressureAddTextFiled(
            itemName: 'pulse',
            controller: pulseTextController,
          ),
          Container(
              margin: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(color: Colors.cyan),
              child: TextButton(
                  onPressed: () async {
                    if (maxPressureTextController.text.isEmpty ||
                        minPressureTextController.text.isEmpty ||
                        pulseTextController.text.isEmpty) {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return  const Dialog(
                              child: Text('you have to fill all items'),
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
                          ));
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const Dialog(
                              child: Text('you put item'),
                            );
                          });
                    }
                  },
                  child: const Text('submit')))
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
    return Row(
      children: [
        Text('$itemName : '),
        SizedBox(
            width: 250,
            child: TextField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter $itemName',
                errorText: null,
              ),
            )),
      ],
    );
  }
}