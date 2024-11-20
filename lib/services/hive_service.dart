import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/adapters.dart';

import '../constants/app_constants.dart';

class HiveService {
  static late final Box _box;
  static Box get box => _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(AppConstants.kBoxName);
  }

  static ValueListenable<Box> getNameListenable() {
    return _box.listenable(keys: [AppConstants.kNameKey]);
  }

  static Future<void> saveName(String name) async {
    if (name.trim().isNotEmpty) {
      await _box.put(AppConstants.kNameKey, name.trim());
    }
  }

  static String getName() {
    return _box.get(AppConstants.kNameKey, defaultValue: '');
  }
}
