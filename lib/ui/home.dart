import 'package:flutter/material.dart';
import 'package:crud_sqflite/ui/entryform.dart';
import 'package:crud_sqflite/models/content.dart';
import 'package:crud_sqflite/helpers/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
//untuk memanggil fungsi yg terdapat di daftar pustaka sqflite
import 'dart:async';
//pendukung program asinkron

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  // pk dbhelper krn masih ada koneksi ke db
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Content> contentList;

  @override
  Widget build(BuildContext context) {
    // definisikan contentlist
    // kl null maka diisi dg list content
    if (contentList == null) {
      contentList = List<Content>();
    }
//scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text('Buku Terbaru'),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        onPressed: () async {
          var content = await navigateToEntryForm(context, null);
          if (content != null)
            addContent(
                content); //kl ditemukan variabel content dibawa ke form add penjualan
        },
      ),
    );
  }

  Future<Content> navigateToEntryForm(
      //redirect ke input content
      BuildContext context,
      Content content) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      //na
      return EntryForm(content);
    }));
    return result;
  }

// menampilkan data ke dalam listview
  ListView createListView() {
    TextStyle textStyle =
        Theme.of(context).textTheme.subhead; //teksnya kaya tema
    return ListView.builder(
      itemCount: count, //hitung banyak list
      itemBuilder: (BuildContext context, int index) {
        //membuat list
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.arrow_drop_down_circle), //icon
                title: Text(
                  this
                      .contentList[index]
                      .judul, //judul yg diambil dari contentlist di index ke berapa
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
                subtitle: Text(
                  'Secondary Text',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  this
                      .contentList[index]
                      .deskripsi, //deskripsi yg diambil dari contentlist di index ke berapa
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  FlatButton(
                    textColor: const Color(0xFF6200EE),
                    onPressed: () {
                      deleteContent(contentList[
                          index]); //jika ditekan nanti akan terhapus
                    },
                    child: const Text('Hapus'),
                  ),
                  FlatButton(
                    textColor: const Color(0xFF6200EE),
                    onPressed: () async {
                      //jika ditekan nanti akan m=redirect ke form input
                      var content = await navigateToEntryForm(
                          context,
                          this.contentList[
                              index]); // dimana sudah ada contentlistnya (judul, foto, deskripsi) di index ke berapa
                      if (content != null)
                        editContent(
                            content); // kalo tidak null maka menjalankan fungsi edit
                    },
                    child: const Text(
                      'Edit',
                    ),
                  ),
                ],
              ),
              Image.network(
                this
                    .contentList[index]
                    .foto, //image network karena menggunakan link
              ),
            ],
          ),
        );
      },
    );
  }

  //buat contaent
  void addContent(Content object) async {
    int result = await dbHelper.insert(object);
    if (result > 0) {
      updateListView(); //kl datanya sudah berhasil di insert
    }
  }

  //edit contact
  void editContent(Content object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      updateListView();
    }
  }

  //delete contact
  void deleteContent(Content object) async {
    int result = await dbHelper.delete(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  //update contact
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //update list
      Future<List<Content>> contentListFuture = dbHelper.getContentList();
      contentListFuture.then((contentList) {
        setState(() {
          this.contentList = contentList; //contentnya
          this.count = contentList.length; //banyaknya
        });
      });
    });
  }
}
