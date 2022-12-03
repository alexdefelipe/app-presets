import 'package:amp_presets/persistance/services/base_service.dart';
import 'package:amp_presets/persistance/services/track_service.dart';
import 'package:sqflite/sqflite.dart';

import '../models/setting.dart';
import '../models/track.dart';

class SettingService with BaseService {
  static final SettingService _instance = SettingService._internal();
  final TrackService _trackService = TrackService();
  final String tableName = 'setting';

  factory SettingService() {
    return _instance;
  }

  SettingService._internal();

  Future<List<Setting>> getSettings() async {
    Database db = await getDatabase();
    final List<Map<String, dynamic>> results = await db.rawQuery(
        'SELECT * FROM setting INNER JOIN track on set_track = tck_id INNER JOIN effect on set_effect = eff_id');
    return results.map((settingMap) {
      Setting setting = Setting.fromMap(settingMap);
      return setting;
    }).toList();
  }

  Future<void> create(Setting setting) async {
    Database db = await getDatabase();
    Track createdTrack = await _trackService.save(setting.track);
    setting.track = createdTrack;
    db.insert(tableName, setting.toMap());
  }

  Future<void> update(Setting setting) async {
    Database db = await getDatabase();
    await _trackService.update(setting.track);
    db.update(tableName, setting.toMap(),
        where: 'set_id = ?', whereArgs: [setting.id]);
  }

  Future<void> delete(Setting setting) async {
    Database db = await getDatabase();
    await db.delete(tableName, where: 'set_id = ?', whereArgs: [setting.id]);
  }
}
