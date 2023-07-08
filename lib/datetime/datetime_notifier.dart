import 'package:hooks_riverpod/hooks_riverpod.dart';

class DatetimeNotifier extends StateNotifier<DateTime> {
  DatetimeNotifier() : super(DateTime.utc(2022,2,22));

  void setDatetime(DateTime date) {
    state = date.toUtc();
  }
}
