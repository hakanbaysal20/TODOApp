


import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAccess{
  static final String databaseName = "todo.sqlite";


  static Future<Database> databaseAccess() async {
    String databasePath = join(await getDatabasesPath(),databaseName);
    if(await databaseExists(databasePath)){
    }else{
      ByteData data = await rootBundle.load("database/$databaseName");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await File(databasePath).writeAsBytes(bytes,flush: true);

    }
    return openDatabase(databasePath);
  }


}