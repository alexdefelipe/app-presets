import 'package:amp_presets/persistance/database_service.dart';
import 'package:sqflite/sqflite.dart';

mixin BaseService {
  Future<Database> getDatabase() async {
    return await DatabaseService().database;
  }
}
