import 'package:amp_presets/persistance/services/base_service.dart';
import 'package:sqflite/sqflite.dart';

import '../models/track.dart';

class TrackService with BaseService {
  static final TrackService _instance = TrackService._internal();
  final String tableName = 'track';

  factory TrackService() {
    return _instance;
  }

  TrackService._internal();

  Future<Track> get(int id) async {
    Database db = await getDatabase();
    final List<Map<String, dynamic>> results =
        await db.query(tableName, where: 'tck_id = ?', whereArgs: [id]);
    return Track.fromMap(results.first);
  }

  Future<Track> save(Track track) async {
    Database db = await getDatabase();
    int trackId = await db.insert(tableName, Track.toMap(track));
    return get(trackId);
  }

  Future<void> update(Track track) async {
    Database db = await getDatabase();
    await db.update(tableName, Track.toMap(track),
        where: 'tck_id = ?', whereArgs: [track.id]);
  }
}
