import '../pressure/pressure_item.dart';

mixin PressureItemRepository {
  Future<void> setPressureItemMap(Map<DateTime, dynamic> map);
  Future<Map<DateTime, dynamic>> getPressureItemMap();
  void deletePressureItemMap();
  String encodeMap(Map<DateTime, dynamic> map);
  Map<DateTime, dynamic> decodeMap(String encodedMap);
}