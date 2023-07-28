
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BottomNavigationBarIndexItem {
 home,
 add,
 dialog,
}

final bottomNavigationBarIndexProvider = StateProvider<BottomNavigationBarIndexItem>((ref) {
  return BottomNavigationBarIndexItem.home;
});
