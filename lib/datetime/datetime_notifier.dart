import 'package:hooks_riverpod/hooks_riverpod.dart';

class DatetimeNotifier extends StateNotifier<DateTime> {
  DatetimeNotifier() : super(DateTime.now().toUtc());

  void setDatetime(DateTime date) {
    state = date.toUtc();
  }
}
