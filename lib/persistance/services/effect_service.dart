import 'package:amp_presets/persistance/models/effect.dart';
import 'package:amp_presets/persistance/services/base_service.dart';
import 'package:sqflite/sqflite.dart';

import '../models/track.dart';

class EffectService with BaseService {
  static final EffectService _instance = EffectService._internal();
  final String tableName = 'effect';

  factory EffectService() {
    return _instance;
  }

  EffectService._internal();

  Future<Track> get(int id) async {
    Database db = await getDatabase();
    final List<Map<String, dynamic>> results =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    return Track.fromMap(results.first);
  }

  Future<List<Effect>> findAll() async {
    Database db = await getDatabase();
    return (await db.query(tableName))
        .map((result) => Effect.fromMap(result))
        .toList();
  }
}
