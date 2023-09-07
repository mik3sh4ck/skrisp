class Geometry {
  Location? location;

  Geometry({this.location});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }

    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class showSales {
  int? status;
  String? message;
  List<Data>? data;

  showSales({this.status, this.message, this.data});

  showSales.fromJson(Map<String, dynamic> json) {
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
  int? idSales;
  String? namaSales;
  String? alamat;
  String? nomorHp;
  String? bank;
  String? noRekening;
  String? latitude;
  String? longitude;

  Data(
      {this.idSales,
      this.namaSales,
      this.alamat,
      this.nomorHp,
      this.bank,
      this.noRekening,
      this.latitude,
      this.longitude});

  Data.fromJson(Map<String, dynamic> json) {
    idSales = json['id_sales'];
    namaSales = json['nama_sales'];
    alamat = json['alamat'];
    nomorHp = json['nomor_hp'];
    bank = json['bank'];
    noRekening = json['no_rekening'];
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_sales'] = this.idSales;
    data['nama_sales'] = this.namaSales;
    data['alamat'] = this.alamat;
    data['nomor_hp'] = this.nomorHp;
    data['bank'] = this.bank;
    data['no_rekening'] = this.noRekening;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
