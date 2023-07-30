import 'package:hooks_riverpod/hooks_riverpod.dart';

class DatetimeNotifier extends StateNotifier<DateTime> {
  DatetimeNotifier({required DateTime dateTime}) : super(dateTime);

  void setDatetime(DateTime date) {
    state = date.toUtc();
  }
}
