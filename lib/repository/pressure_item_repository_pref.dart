import 'package:flutter_training/repository/pressure_item_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../pressure/pressure_item.dart';

class PressureItemRepositoryPref implements PressureItemRepository {

  @override
  Future<void> setPressureItemMap(Map<DateTime, dynamic> map) async {
    final pref = await SharedPreferences.getInstance();
    final jsonString = encodeMap(map);
    await pref.setString('PRESSURE_ITEM_MAP', jsonString);
  }

  @override
  Future<Map<DateTime, dynamic>> getPressureItemMap() async {
    final pref = await SharedPreferences.getInstance();
    final jsonString = pref.getString('PRESSURE_ITEM_MAP');
    if (jsonString == null) {
      return {};
    }
    final decodedJson = decodeMap(jsonString);
    print(decodedJson);
    return decodedJson;
  }

  @override
  String encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    String encodeMap = json.encode(newMap);
    return encodeMap;
  }

  @override
  Map<DateTime, dynamic> decodeMap(String encodedMap) {
    Map<String, dynamic> decodedMap = json.decode(encodedMap);
    Map<DateTime, List<PressureItem>> newMap = {};
    decodedMap.forEach((key, value) {
      List<PressureItem> list = [];
      for (var element in value) {
        list.add(PressureItem(uuid: element['uuid'],
            maxPressure: element['maxPressure'],
            minPressure: element['minPressure'],
            pulse: element['pulse'],
            measurementTime: DateTime.parse(element['measurementTime'])));
      }
      newMap[DateTime.parse(key)] = list;
    });
    return newMap;
  }

  @override
  void deletePressureItemMap() {
    // TODO: implement deletePressureItemMap
  }

  List<String> getPressureItemStringOnly(PressureItem item) {
    return [
      item.uuid!,
      item.maxPressure!.toString(),
      item.minPressure!.toString(),
      item.pulse!.toString(),
      item.measurementTime!.toString()
    ];
  }
}
