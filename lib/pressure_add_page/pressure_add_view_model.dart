import 'package:flutter_riverpod/flutter_riverpod.dart';

class PressureAddViewModel {
  PressureAddViewModel({
    required this.ref,
  });

  final WidgetRef ref;

  void onTapSubmit({
    required String max,
    required String min,
    required String pulse,
}) {

  }



  int _convertTextToInt(String text) {
    int num;
    if (text.isEmpty) {
      return 1;
    }
    try {
      num = int.parse(text);
    } catch (e) {
      print(e);
      return -1;
    }
    return num;
  }
}
