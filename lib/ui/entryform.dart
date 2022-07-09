import 'package:flutter/material.dart';
import 'package:crud_sqflite/models/content.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class EntryForm extends StatefulWidget {
  final Content content;
// menangkap variabel content
  EntryForm(this.content);

  @override
  EntryFormState createState() => EntryFormState(this.content);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Content content;

  EntryFormState(this.content);
// text editing controller utk membaca inputan text fill
  TextEditingController judulController = TextEditingController();
  TextEditingController fotoController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (content != null) {
      //kl tidak null maka membaca isi judul, foto, deskripsi
      judulController.text = content.judul;
      fotoController.text = content.foto;
      deskripsiController.text = content.deskripsi;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: content == null
              ? Text('Tambah')
              : Text('Rubah'), //kl null berarti tambah, kl tdk null maka ubah
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            //krn tiap content hght nya beda, jadi nanti bisa discroll
            // kl pake yg lain, pas heightnya banyak nanti bisa eror
            children: <Widget>[
              RotateAnimatedTextKit(
                //buat animasi
                pause: const Duration(milliseconds: 3),
                text: [
                  'Tambah Konten',
                ],
                textStyle: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w100),
                repeatForever: true,
              ),

              // nama
              Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: TextField(
                  controller: judulController, //panggil controller
                  keyboardType: TextInputType.text, //tipe keyboardnya
                  decoration: InputDecoration(
                    labelText: 'Judul',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0), //border radius
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // telepon
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: fotoController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Link Foto',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: deskripsiController,
                  keyboardType: TextInputType.text,
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      //agar lebar button menyesuaikan dg jumlah button yg ada
                      child: RaisedButton(
                        color:
                            Theme.of(context).primaryColorDark, //temanya dark
                        textColor:
                            Theme.of(context).primaryColorLight, //temanya
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (content == null) {
                            //kl null
                            // diisi dengan controller td, ditambah/data baru
                            content = Content(judulController.text,
                                fotoController.text, deskripsiController.text);
                          } else {
                            // variabel dri content diupdate dengan controller td
                            content.judul = judulController.text;
                            content.foto = fotoController.text;
                            content.deskripsi = deskripsiController.text;
                          }
                          // kembali ke layar sebelumnya dengan membawa objek contact
                          Navigator.pop(context, content);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context); //kembali ke layar sbelumnya
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
