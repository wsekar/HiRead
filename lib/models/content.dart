class Content {
  //inisialisasi variabel
  int _id;
  String _judul;
  String _foto;
  String _deskripsi;

//class xontruct, utk menerima pengiriman variabel antar class di mana variabelnya sesuai dengan variabel yg diinisialisasi di atas
  Content(this._judul, this._foto, this._deskripsi);
  //convert class tadi ke sebuah map
  // agar constructor tadi mengambil data kemudian diterjemahkan ke dalam variabel
  // kemudian di convert ke map, isi dari map nanti menjadi inputan dalam sqlite
  Content.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._judul = map['judul'];
    this._foto = map['foto'];
    this._deskripsi = map['deskripsi'];
  }
  // fungsi get utk mengambil nilai dari map tadi
  // yg pake _ utk menampung data sementara
  // yg ga pake, utk nama atribut di dtbase.
  int get id => _id;
  String get judul => _judul;
  String get foto => _foto;
  String get deskripsi => _deskripsi;

  // set variabel judul, foto, dan deskripsi, tujuannya agar variabel ini nantinya dapat diisikan value
  set judul(String value) {
    _judul = value;
  }

  set foto(String value) {
    _foto = value;
  }

  set deskripsi(String value) {
    _deskripsi = value;
  }

//cpnvert ke map, yg jd anggota map = fil pd tabel sqlite
// utk ngirim map ke fungsi dbhelper, tdk perlu menerjemahkan arraynya, cukup panggil map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['judul'] = judul; //mengambil get judul
    map['foto'] = foto; //foto
    map['deskripsi'] = deskripsi; //deskripsi
    return map; //
  }
}
