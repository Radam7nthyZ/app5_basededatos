import 'dart:io';

import 'package:app5_basededatos/models/cole_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBadmin {
  Database? myDatabase;

  static final DBadmin db = DBadmin._();
  DBadmin._();

  Future<Database?> checkDatabase() async {
    if (myDatabase != null) {
      return myDatabase;
    }

    myDatabase = await initDatabase();
    return myDatabase;
  }

  Future<Database?> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "ColegioDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database dbx, int version) async {
      // CREAR LA TABLA CORRESPONDIENTE.....
      await dbx.execute(
          "CREATE TABLE alumno(id INTEGER PRIMARY KEY AUTOINCREMENT, nombres TEXT, apellidos TEXT, correo TEXT, status TEXT, direccion TEXT )");
    });
  }

  // INSERTANDO UN INSERTRAW....
  Future<int> insertRawColegio(ColegioModel model) async {
    Database? db = await checkDatabase();
    int res = await db!.rawInsert(
        "INSERT INTO alumno( nombres, apellidos, status) VALUES ('${model.nombres}','${model.apellidos}','${model.status.toString()}')");
    return res;
  }

  // INSERT NORMAL.......
  Future<int> insertColegio(ColegioModel model) async {
    Database? db = await checkDatabase();
    int res = await db!.insert(
      "alumno",
      {
        "nombres": "model.nombres",
        "apellidos": " model.apellidos",
        "status": "model.status",
      },
    );
    return res;
  }

  // GETRAW OBTENER TODOS LOS REGISTROS .............
  getRawColegios() async {
    Database? db = await checkDatabase();
    List Colegios =
        await db!.rawQuery("SELECT * FROM Colegio"); // sentencia dura
    print(Colegios);
  }

  // GET UN POCO MAS RESUMIDO O CONCRETO...........
  // AGRENGANDO LIST CON MAPAS FUTURE..........
  Future<List<ColegioModel>> getColegios() async {
    Database? db = await checkDatabase();
    List<Map<String, dynamic>> Colegios =
        await db!.query("Colegio"); // sentencia indefinido
    List<ColegioModel> ColegioModelList =
        Colegios.map((e) => ColegioModel.deMapAModel(e)).toList();

    // Colegios.forEach((element) {
    //   ColegioModel Colegio = ColegioModel.deMapAModel(element);
    //   ColegioModelList.add(Colegio);
    // });

    return ColegioModelList;
  }

  // ACTUALIZAR LOS DATOS........
  updateRawColegio() async {
    Database? db = await checkDatabase();
    int res = await db!.rawUpdate(
        "UPDATE alumno SET nombres = 'leo', apellidos = 'usca', status = 'true' WHERE id = 2 ");
    print(res);
  }

  // ACTUALIZAR NO TODOS LOS DATOS SOLO LOS QUE DESIGNAMOS...
  updateColegio() async {
    Database? db = await checkDatabase();
    int res = await db!.update(
        "alumno",
        {
          "nombres": "leo ir de compras al moll",
          "apellido": "usca siempre presente",
          "status": "false",
        },
        where: "id = 2");
    print(res);
  }

  // ELIMINAR  LOS DATOS........
  deleteRawColegio() async {
    Database? db = await checkDatabase();
    int res = await db!.rawDelete("DELETE FROM alumno WHERE id = 2");
    print(res);
  }

  // ELIMINAR NO TODOS LOS DATOS SOLO LOS QUE DESIGNAMOS...
  deleteColegio() async {
    Database? db = await checkDatabase();
    int res = await db!.delete("alumno", where: "id = 3");
    print(res);
  }
}
