import 'package:flutter/material.dart';
import 'package:flutter_training/main_page/main_page.dart';
import 'package:flutter_training/pressure/pressure_item.dart';
import 'package:flutter_training/pressure/pressure_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  initializeDateFormatting('ja')
      .then((_) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Pressure Management',
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(),
        body: MainPage(),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.keyboard_return),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph),
              label: 'Open Dialog',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: '',
            ),
          ],
        ),
        floatingActionButton: IconButton(
          onPressed: () {
            ref.read(pressureProvider.notifier).testAdd(DateTime(2023, 7, 10),
                PressureItem(maxPressure: 130, minPressure: 100, pulse: 90));
          },
          icon: const Icon(Icons.add_circle_outline),
        ),
      ),
    );
  }
}
