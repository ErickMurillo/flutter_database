import 'dart:io';
import 'package:flutter_database/src/models/cursos_model.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the tables
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'prueba.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE if not exists Cursos('
          'id INTEGER PRIMARY KEY,'
          'titulo TEXT,'
          'imagen TEXT,'
          'descripcion TEXT,'
          'fecha TEXT,'
          'activo INTEGER'
          ')');
    });
  }
  // 'activo INTEGER'

  // Insert on database
  createCursos(Cursos newCursos) async {
    // await deleteAllCursos();
    final db = await database;
    final res = await db.insert('Cursos', newCursos.toJson());

    return res;
  }

  // Delete all
  Future<int> deleteAllCursos() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Cursos');

    return res;
  }

  //select all
  Future<List<Cursos>> getAllCursos() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Cursos");

    List<Cursos> list =
        res.isNotEmpty ? res.map((c) => Cursos.fromJson(c)).toList() : [];

    return list;
  }
}
