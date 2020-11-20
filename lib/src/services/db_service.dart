import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqllite_app/src/models/trail.dart';

class DatabaseService {
  Database _db;

  initDatabase() async {

    _db = await openDatabase('assets/trails.db');
    var databasePath = await getDatabasesPath();
    var path = join(databasePath,'trails.db');

    //Check if DB exists 
    var exists = await databaseExists(path);

    if (!exists){
      print('Create a new copy from assets');

      //Check if parent directory exists
      try {
        await Directory(dirname(path)).create(recursive:true);
      } catch (_){}

      //Copy from assets
      ByteData data = await rootBundle.load(join("assets","trails.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);

      //Write and flush the bytes
      await File(path).writeAsBytes(bytes,flush: true);
    }

    //Open the database
    _db = await openDatabase(path, readOnly: true);

  }

  Future<List<Trail>> getTrails() async {
    await initDatabase();
    List<Map> list = await _db.rawQuery('SELECT * FROM Trails');
    return list.map((trail) => Trail.fromJson(trail)).toList();
  }

  dispose(){
    _db.close();
  }

}