import 'package:freezed_annotation/freezed_annotation.dart';
part 'pressure_item.freezed.dart';


@freezed
abstract class PressureItem with _$PressureItem {
  const factory PressureItem({
    String? uuid,
    int? maxPressure,
    int? minPressure,
    int? pulse,
    DateTime? measurementTime,
  }) = _PressureItem;
}
