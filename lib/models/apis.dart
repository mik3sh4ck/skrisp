import "dart:convert";

import "package:http/http.dart" as http;
import "package:sales/models/showStock.dart";

String _linkpath = "http://192.168.18.204:38560/";

class ServicesUser {
  //login
  Future getAuth(username, password) async {
    final response = await http.get(Uri.parse(
        "${_linkpath}login?username=${username}&password=${password}"));
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespData];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future getAuthAdmin(username, password) async {
    final response = await http.get(Uri.parse(
        "${_linkpath}login-admin?username=${username}&password=${password}"));
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      return [jsonRespStatus, jsonRespData];
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future<List> getStockList() async {
    final response = await http.get(Uri.parse("${_linkpath}stk/showstock"));
    if (response.statusCode == 200) {
      List items = [];
      // ignore: unused_local_variable
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];

      items = jsonRespData;
      return items;
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future<List<String>> getStockListName() async {
    final response = await http.get(Uri.parse("${_linkpath}stk/showstock"));
    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      for (var element in jsonRespData) {
        items.add(element["nama_product"]);
      }
      return items;
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future updateLocation(longitude, latitude, iduser) async {
    final response = await http.put(Uri.parse(
        "${_linkpath}sales/updateSalesLocation?longitude=${longitude}&latitude=${latitude}&id_user=${iduser}"));
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      print(jsonRespData);
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future<List> showHeaderOrder(idSales) async {
    print(idSales);
    List items = [];
    final response = await http
        .get(Uri.parse("${_linkpath}ord/showheaderorder?id_sales=${idSales}"));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      items = jsonRespData;
      return items;
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future<List> showPelanggan() async {
    List items = [];
    final response =
        await http.get(Uri.parse("${_linkpath}plgn/showpelanggan"));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      items = jsonRespData;
      return items;
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future<List<String>> getAllNamaPelanggan() async {
    List<String> items = [];
    final response =
        await http.get(Uri.parse("${_linkpath}plgn/showpelanggan"));
    if (response.statusCode == 200) {
      var jsonRespStatus = json.decode(response.body)['status'];
      var jsonRespData = json.decode(response.body)['data'];
      for (var element in jsonRespData) {
        items.add(element["nama_toko"]);
      }

      return items;
    } else {
      throw Exception("Gagal mengambil data");
    }
  }
}
