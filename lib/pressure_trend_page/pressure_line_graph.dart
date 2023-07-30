import 'package:flutter/cupertino.dart';
import 'package:flutter_training/pressure/pressure_item.dart';
import 'package:flutter_training/pressure/pressure_provider.dart';
import 'package:flutter_training/pressure_trend_page/pressure_trend_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class PressureLineGraph extends HookConsumerWidget {
  PressureLineGraph(
      {required this.startDay,
      required this.endDay,
      required this.ref,
      super.key});

  final DateTime startDay;
  final DateTime endDay;
  final WidgetRef ref;
  TooltipBehavior? _tooltipBehavior;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      _tooltipBehavior = TooltipBehavior(enable: true);
    }, []);
    final pressureItemMapAveragePerDayWithRange =
        PressureTrendViewModel(ref: ref, context: context)
            .getPressureItemMapAveragePerDayWithRange(
                startDay: startDay, endDay: endDay);
    return Center(
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'pressure charts(max, min, pulse)'),
            legend: const Legend(isVisible: true),
            tooltipBehavior: _tooltipBehavior,
            series: <LineSeries<PressureItem, String>>[
          LineSeries<PressureItem, String>(
              dataSource: <PressureItem>[
                for (var pressureItem
                    in pressureItemMapAveragePerDayWithRange.values)
                  pressureItem
              ],

              /// second argument 'i' is count of item (0 origin)
              xValueMapper: (PressureItem pressureItem, i) => i.toString(),
              yValueMapper: (PressureItem pressureItem, _) =>
                  pressureItem.maxPressure,
              // Enable data label
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            name: 'max pressure'
          ),
          LineSeries<PressureItem, String>(
              dataSource: <PressureItem>[
                for (var pressureItem
                    in pressureItemMapAveragePerDayWithRange.values)
                  pressureItem
              ],

              /// second argument 'i' is count of item (0 origin)
              xValueMapper: (PressureItem pressureItem, i) => i.toString(),
              yValueMapper: (PressureItem pressureItem, _) =>
                  pressureItem.minPressure,
              // Enable data label
              dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.inside),
              name: 'min pressure'
          ),
          LineSeries<PressureItem, String>(
              dataSource: <PressureItem>[
                for (var pressureItem
                    in pressureItemMapAveragePerDayWithRange.values)
                  pressureItem
              ],

              /// second argument 'i' is count of item (0 origin)
              xValueMapper: (PressureItem pressureItem, i) => i.toString(),
              yValueMapper: (PressureItem pressureItem, _) =>
                  pressureItem.pulse,
              // Enable data label
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              name: 'pulse'
          ),
        ]));
  }
}
