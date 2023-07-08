import 'package:freezed_annotation/freezed_annotation.dart';

part 'pressure_item.freezed.dart';


@freezed
abstract class PressureItem with _$PressureItem {
  const factory PressureItem({
    int? maxPressure,
    int? minPressure,
    int? pulse,
  }) = _PressureItem;
}
