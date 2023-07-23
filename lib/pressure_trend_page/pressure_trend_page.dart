import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PressureTrendPage extends ConsumerWidget {
  const PressureTrendPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        child:Text('Pressure trend page'),
      ),
    );
  }
}
