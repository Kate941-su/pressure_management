import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/datetime/datetime_provider.dart';
import 'package:flutter_training/pressure_trend_page/pressure_trend_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PressureTrendPage extends HookConsumerWidget {
  const PressureTrendPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialDayController = useTextEditingController();
    final finalDayController = useTextEditingController();
    final startDay = ref.watch(startlDayProvider);
    final endDay = ref.watch(endDayProvider);
    useEffect(() {
      return null;
    }, [initialDayController, finalDayController]);
    return Scaffold(
      body: Column(
        children: [
          _DailyTextFormField(
            textEditingController: initialDayController,
            label: '開始日',
          ),
          IconButton(
              onPressed: () {
                print(startDay);
                print(endDay);
              },
              icon: const Icon(Icons.remove_red_eye))
        ],
      ),
    );
  }
}

class _DailyTextFormField extends HookConsumerWidget {
  const _DailyTextFormField(
      {required this.textEditingController, required this.label, super.key});

  final TextEditingController textEditingController;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pressureTrendViewModel =
        PressureTrendViewModel(ref: ref, context: context);
    return Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          OutlinedButton(
            // （2） ボタンを押した時に入力できるようにする
            onPressed: () {
              pressureTrendViewModel.openDateRange(context);
            },
            child: const Icon(Icons.calendar_month),
          ),
          // : （省略）
        ]));
  }
}
