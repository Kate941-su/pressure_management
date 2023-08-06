import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/datetime/datetime_provider.dart';
import 'package:flutter_training/pressure/pressure_provider.dart';
import 'package:flutter_training/pressure_trend_page/pressure_line_graph.dart';
import 'package:flutter_training/pressure_trend_page/pressure_trend_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PressureTrendPage extends HookConsumerWidget {
  const PressureTrendPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialDayController = useTextEditingController();
    final finalDayController = useTextEditingController();
    final startDay = ref.watch(startDayProvider);
    final endDay = ref.watch(endDayProvider);
    final pressureTrendViewModel = PressureTrendViewModel(ref: ref, context: context);
    useEffect(() {
      return null;
    }, [initialDayController, finalDayController]);
    return Scaffold(
      body: Column(
        children: [
          PressureLineGraph(startDay: startDay, endDay: endDay, ref: ref),
          _DailyTextFormField(
            textEditingController: initialDayController,
            label: '開始日',
          ),
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
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
            // （2） ボタンを押した時に入力できるようにする
            onPressed: () {
              pressureTrendViewModel.openDateRange(context);
            },
            child: const Text('表示期間を選択🗓'),
          ),
          // : （省略）
        ]));
  }
}
