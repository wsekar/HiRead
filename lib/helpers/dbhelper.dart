import 'package:sqflite/sqflite.dart';
import 'dart:async';
//mendukug pemrograman asinkron
import 'dart:io';
//bekerja pada file dan directory
import 'package:path_provider/path_provider.dart';
import 'package:crud_sqflite/models/content.dart';
//pubspec.yml

//kelass Dbhelper
class DbHelper {
  // terbetuk saat berhasil import package sqflite
  // dbhelper berisi sintak query yg menuju ke db
  static DbHelper _dbHelper;
  static Database _database;
// create nama db, dan tb
  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
// future, tipenya asinkronus akan menangani koneksi dl bg aplikasi
// jika nanti ada masalah, aplikasi berjalan tapi datanya null
  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    // directory db emplyee
    String path = directory.path + 'employeeeee.db';

    //create, read databases
    //version 1
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  //buat tabel baru dengan nama content
  void _createDb(Database db, int version) async {
    // await digunakan saat menggunakan future async dan dbhelper
    // sintaksnya sbg berikut
    await db.execute('''
      CREATE TABLE contentnih (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT,
        foto TEXT,
        deskripsi TEXT
      )
    ''');
  }

//get db utk menggunakan koneksi(insert, update, del)
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

// select,
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    //
    var mapList = await db.query('contentnih', orderBy: 'judul');
    return mapList;
  }

//create databases
  Future<int> insert(Content object) async {
    Database db = await this.database;
    //count
    int count = await db.insert('contentnih', object.toMap());
    return count;
  }

//update databases
  Future<int> update(Content object) async {
    Database db = await this.database;
    // object tomap() dri model content
    int count = await db.update('contentnih', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.database;
    // where maksudnya id yng dimaksud
    int count = await db.delete('contentnih', where: 'id=?', whereArgs: [id]);
    // count utk cek datanya berhasil didelete
    return count;
  }

// getcontentlist , yg diambil dari fungsi select, dibawa ke contentmaplist
// krn bentuknya list, maka ini mengacu ke model content, yg didalamnya ada id, judul dll
  Future<List<Content>> getContentList() async {
    var contentMapList = await select();
    int count = contentMapList.length;
    List<Content> contentList = List<Content>();
    for (int i = 0; i < count; i++) {
      //add ke dalam content list
      contentList.add(Content.fromMap(contentMapList[i]));
    }
    return contentList;
  }
}
