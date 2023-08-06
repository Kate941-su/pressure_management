import 'package:flutter/material.dart';
import 'package:flutter_training/datetime/datetime_provider.dart';
import 'package:flutter_training/main_page/main_page.dart';
import 'package:flutter_training/pressure/bottom_navigation_bar_index_provider.dart';
import 'package:flutter_training/pressure/pressure_provider.dart';
import 'package:flutter_training/pressure_add_page/pressure_add_page.dart';
import 'package:flutter_training/pressure_trend_page/pressure_trend_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
void main() {
  initializeDateFormatting('ja')
      .then((_) => runApp(ProviderScope(child: MyApp())));
}

class MyApp extends HookConsumerWidget {
  MyApp({Key? key}) : super(key: key);
  final List pageList = [
    const MainPage(),
    PressureAddPage(),
    const PressureTrendPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasSelected = ref.watch(hasSelectedProvider);
    useEffect(() {
      ref.read(pressureProvider.notifier).initialize();
    },[]);
    final bottomNavigationBarSelectedIndex =
        ref.watch(bottomNavigationBarIndexProvider);
    return MaterialApp(
      title: 'Pressure Management',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('血圧手帳'),
        ),
        body: pageList[bottomNavigationBarSelectedIndex.index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomNavigationBarSelectedIndex.index,
          onTap: (index) {
            /// TODO enumにする
            if (!hasSelected && index == 1) {

            } else {
              ref.read(bottomNavigationBarIndexProvider.notifier).state =
              BottomNavigationBarIndexItem.values[index];
            }
          },
          showUnselectedLabels: false,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month,
              ),
              label: 'daily',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph),
              label: 'Open Dialog',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.edit),
            //   label: 'Edit',
            // ),
          ],
        ),
      ),
    );
  }
}
