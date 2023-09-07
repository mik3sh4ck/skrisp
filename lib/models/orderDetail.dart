class orderDetail {
  int? status;
  String? message;
  List<Data>? data;

  orderDetail({this.status, this.message, this.data});

  orderDetail.fromJson(Map<String, dynamic> json) {
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
  String? namaToko;
  String? alamat;
  String? kota;
  String? noTelp;
  String? totalBarang;
  String? noOrder;
  String? tanggalPesanan;
  String? tanggalPengiriman;
  String? pembayaran;
  String? downPayment;
  String? tanggalPembayaran;
  String? namaSales;
  int? subTotal;
  int? retur;
  List<DetailOrder>? detailOrder;

  Data(
      {this.idOrder,
      this.namaToko,
      this.alamat,
      this.kota,
      this.noTelp,
      this.totalBarang,
      this.noOrder,
      this.tanggalPesanan,
      this.tanggalPengiriman,
      this.pembayaran,
      this.downPayment,
      this.tanggalPembayaran,
      this.namaSales,
      this.subTotal,
      this.retur,
      this.detailOrder});

  Data.fromJson(Map<String, dynamic> json) {
    idOrder = json['id_order'];
    namaToko = json['nama_toko'];
    alamat = json['alamat'];
    kota = json['kota'];
    noTelp = json['no_telp'];
    totalBarang = json['total_barang'];
    noOrder = json['no_order'];
    tanggalPesanan = json['tanggal_pesanan'];
    tanggalPengiriman = json['tanggal_pengiriman'];
    pembayaran = json['pembayaran'];
    downPayment = json['down_payment'];
    tanggalPembayaran = json['tanggal_pembayaran'];
    namaSales = json['nama_sales'];
    subTotal = json['sub_total'];
    retur = json['retur'];
    if (json['detail_Order'] != null) {
      detailOrder = <DetailOrder>[];
      json['detail_Order'].forEach((v) {
        detailOrder!.add(new DetailOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_order'] = this.idOrder;
    data['nama_toko'] = this.namaToko;
    data['alamat'] = this.alamat;
    data['kota'] = this.kota;
    data['no_telp'] = this.noTelp;
    data['total_barang'] = this.totalBarang;
    data['no_order'] = this.noOrder;
    data['tanggal_pesanan'] = this.tanggalPesanan;
    data['tanggal_pengiriman'] = this.tanggalPengiriman;
    data['pembayaran'] = this.pembayaran;
    data['down_payment'] = this.downPayment;
    data['tanggal_pembayaran'] = this.tanggalPembayaran;
    data['nama_sales'] = this.namaSales;
    data['sub_total'] = this.subTotal;
    data['retur'] = this.retur;
    if (this.detailOrder != null) {
      data['detail_Order'] = this.detailOrder!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailOrder {
  int? idDetailOrder;
  String? namaBarang;
  int? jumlah;
  String? satuan;
  int? hargaJual;
  int? subTotal;
  List<DetailOrderBarang>? detailOrderBarang;

  DetailOrder(
      {this.idDetailOrder,
      this.namaBarang,
      this.jumlah,
      this.satuan,
      this.hargaJual,
      this.subTotal,
      this.detailOrderBarang});

  DetailOrder.fromJson(Map<String, dynamic> json) {
    idDetailOrder = json['Id_detail_order'];
    namaBarang = json['Nama_barang'];
    jumlah = json['jumlah'];
    satuan = json['satuan'];
    hargaJual = json['harga_jual'];
    subTotal = json['sub_total'];
    if (json['detail_order_barang'] != null) {
      detailOrderBarang = <DetailOrderBarang>[];
      json['detail_order_barang'].forEach((v) {
        detailOrderBarang!.add(new DetailOrderBarang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id_detail_order'] = this.idDetailOrder;
    data['Nama_barang'] = this.namaBarang;
    data['jumlah'] = this.jumlah;
    data['satuan'] = this.satuan;
    data['harga_jual'] = this.hargaJual;
    data['sub_total'] = this.subTotal;
    if (this.detailOrderBarang != null) {
      data['detail_order_barang'] =
          this.detailOrderBarang!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailOrderBarang {
  String? jenisUkuran;
  int? jumlah;
  String? satuan;

  DetailOrderBarang({this.jenisUkuran, this.jumlah, this.satuan});

  DetailOrderBarang.fromJson(Map<String, dynamic> json) {
    jenisUkuran = json['jenis_ukuran'];
    jumlah = json['jumlah'];
    satuan = json['satuan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jenis_ukuran'] = this.jenisUkuran;
    data['jumlah'] = this.jumlah;
    data['satuan'] = this.satuan;
    return data;
  }
}
