import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBadmin {
  Database? myDatabase;

  static final DBadmin db = DBadmin._();
  DBadmin._();

  chekDatabase() {
    if (myDatabase != null) {
      return myDatabase;
    }

    myDatabase = initDatabase();
    return myDatabase;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "ColegioDB.db");
    await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database dbx, int version) {
      dbx.execute(
          "CREATE TABLE alumno(id INTEGER PRIMARY KEY AUTOINCREMENT, nombres TEXT, apellidos TEXT, correo TEXT, status TEXT, direccion TEXT )");
    });
  }
}
