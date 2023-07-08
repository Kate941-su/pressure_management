import 'package:hooks_riverpod/hooks_riverpod.dart';

class DatetimeNotifier extends StateNotifier<DateTime> {
  DatetimeNotifier() : super(DateTime.now());

  void setDatetime(DateTime date) {
    state = date;
  }
}
