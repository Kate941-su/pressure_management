import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'datetime_notifier.dart';

final selectDayProvider = StateNotifierProvider<DatetimeNotifier, DateTime>(
    (ref) => DatetimeNotifier(dateTime: DateTime.now().toUtc()));

final focusDayProvider = StateNotifierProvider<DatetimeNotifier, DateTime>(
    (ref) => DatetimeNotifier(dateTime: DateTime.now().toUtc()));

final startDayProvider = StateNotifierProvider<DatetimeNotifier, DateTime>(
    (ref) => DatetimeNotifier(
        dateTime: DateTime.now().toUtc().subtract(const Duration(days: 7))));

final endDayProvider = StateNotifierProvider<DatetimeNotifier, DateTime>(
    (ref) => DatetimeNotifier(dateTime: DateTime.now().toUtc()));

final measurementTimeProvider =
    StateNotifierProvider<DatetimeNotifier, DateTime>(
        (ref) => DatetimeNotifier(dateTime: DateTime.now().toUtc()));

// 初回起動時に日付が選択されたか判断するためのプロバイダ
final hasSelectedProvider = StateProvider((ref) => false);
