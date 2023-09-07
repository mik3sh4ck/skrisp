class headerOrder {
  int? status;
  String? message;
  List<Data>? data;

  headerOrder({this.status, this.message, this.data});

  headerOrder.fromJson(Map<String, dynamic> json) {
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
  int? idOrder;
  String? noOrder;
  int? subTotal;
  String? namaSales;
  String? namaToko;
  String? kota;
  String? totalBarang;

  Data(
      {this.idOrder,
      this.noOrder,
      this.subTotal,
      this.namaSales,
      this.namaToko,
      this.kota,
      this.totalBarang});

  Data.fromJson(Map<String, dynamic> json) {
    idOrder = json['id_order'];
    noOrder = json['no_order'];
    subTotal = json['sub_total'];
    namaSales = json['nama_sales'];
    namaToko = json['nama_toko'];
    kota = json['kota'];
    totalBarang = json['total_barang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_order'] = this.idOrder;
    data['no_order'] = this.noOrder;
    data['sub_total'] = this.subTotal;
    data['nama_sales'] = this.namaSales;
    data['nama_toko'] = this.namaToko;
    data['kota'] = this.kota;
    data['total_barang'] = this.totalBarang;
    return data;
  }
}
