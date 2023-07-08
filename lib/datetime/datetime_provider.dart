import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'datetime_notifier.dart';

final selectDayProvider = StateNotifierProvider<DatetimeNotifier, DateTime>(
    (ref) => DatetimeNotifier());

final focusDayProvider = StateNotifierProvider<DatetimeNotifier, DateTime>(
(ref) => DatetimeNotifier());
