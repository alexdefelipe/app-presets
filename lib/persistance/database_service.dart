import 'dart:async';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();

  factory DatabaseService() => _databaseService;

  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'database.sqlite');
    return await openDatabase(path,
        onCreate: _onCreate, onConfigure: _onConfigure, version:1);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    List<String> sqlStatements = [];
    String ddl = await rootBundle.loadString(join('assets', 'bin', 'sql', 'ddl.sql'));
    sqlStatements.addAll(ddl.split(';'));
    String dml = await rootBundle.loadString(join('assets', 'bin', 'sql', 'dml.sql'));
    sqlStatements.addAll(dml.split(';'));
    db.execute('DROP TABLE IF EXISTS setting');
    db.execute('DROP TABLE IF EXISTS effect');
    db.execute('DROP TABLE IF EXISTS track');
    for (var statement in sqlStatements) {
      db.execute(statement);
    }
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
