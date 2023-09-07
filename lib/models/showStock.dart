class showStock {
  int? status;
  String? message;
  List<Data>? data;

  showStock({this.status, this.message, this.data});

  showStock.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? idProduct;
  String? namaProduct;
  String? jenisProduct;
  int? harga;
  List<Ukuran>? ukuran;

  Data(
      {this.idProduct,
      this.namaProduct,
      this.jenisProduct,
      this.harga,
      this.ukuran});

  Data.fromJson(Map<String, dynamic> json) {
    idProduct = json['id_product'];
    namaProduct = json['nama_product'];
    jenisProduct = json['jenis_product'];
    harga = json['harga'];
    if (json['ukuran'] != null) {
      ukuran = <Ukuran>[];
      json['ukuran'].forEach((v) {
        ukuran!.add(new Ukuran.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_product'] = this.idProduct;
    data['nama_product'] = this.namaProduct;
    data['jenis_product'] = this.jenisProduct;
    data['harga'] = this.harga;
    if (this.ukuran != null) {
      data['ukuran'] = this.ukuran!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ukuran {
  int? idUkuran;
  String? ukuranProduct;
  int? stock;

  Ukuran({this.idUkuran, this.ukuranProduct, this.stock});

  Ukuran.fromJson(Map<String, dynamic> json) {
    idUkuran = json['id_ukuran'];
    ukuranProduct = json['ukuran_product'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_ukuran'] = this.idUkuran;
    data['ukuran_product'] = this.ukuranProduct;
    data['stock'] = this.stock;
    return data;
  }
}
