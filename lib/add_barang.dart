import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sales/add_order.dart';
import 'package:sales/detail_transaksi.dart';
import 'package:sales/models/apis.dart';
import 'package:sales/models/orderDetail.dart';
import 'package:sales/models/showStock.dart';
import 'package:sales/themes/colors.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'global.dart';
import 'package:path/path.dart' as path;

List<DetailOrderBarang> detailOrderBarang = [
  DetailOrderBarang(jenisUkuran: "M", jumlah: 10, satuan: "pcs"),
  DetailOrderBarang(jenisUkuran: "L", jumlah: 10, satuan: "pcs")
];

class AddBarangTransaksi extends StatefulWidget {
  const AddBarangTransaksi({super.key});

  @override
  State<AddBarangTransaksi> createState() => _AddBarangTransaksiState();
}

class _AddBarangTransaksiState extends State<AddBarangTransaksi> {
  late Future<List<String>> _currencies;
  late Future stockAda;
  late List<showStock> abc;

  ServicesUser servicesUser = ServicesUser();
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  String? dropdownValue;
  String satuanValueXS = satuan.first;
  String satuanValueS = satuan.first;
  String satuanValueM = satuan.first;
  String satuanValueL = satuan.first;
  String satuanValueXL = satuan.first;
  String satuanValueXXl = satuan.first;

  int stockValue1 = 0;
  int stockValue2 = 0;
  int stockValue3 = 0;
  int stockValue4 = 0;
  int stockValue5 = 0;
  int stockValue6 = 0;

  @override
  void initState() {
    super.initState();
    stockAda = servicesUser.getStockList();
    _currencies = servicesUser.getStockListName();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: lightText,
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(this.context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: darkText,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Add Barang",
                    style: GoogleFonts.oxygen(
                        fontSize: 20,
                        color: darkText,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          color: darkText,
                          size: 25,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Madiun",
                          style: GoogleFonts.oxygen(
                              fontSize: 16,
                              color: darkText,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 15, right: 20, left: 20, bottom: 50),
            child: Container(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nama Barang"),
                        FutureBuilder<List<String>>(
                            future: servicesUser.getStockListName(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!;
                                return DropdownMenu(
                                    enableFilter: true,
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    initialSelection: data.first,
                                    onSelected: (String? value) {
                                      setState(() {
                                        dropdownValue = value!;
                                        stockAda = servicesUser.getStockList();
                                      });
                                    },
                                    dropdownMenuEntries:
                                        data.map((String? value) {
                                      return DropdownMenuEntry<String>(
                                          value: value.toString(),
                                          label: value.toString());
                                    }).toList());
                              } else {
                                return const CircularProgressIndicator();
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Stock: "),
                            Spacer(),
                            Text("Harga Jual: "),
                            Spacer(),
                            Text("Rp. 54.000 / pcs")
                          ],
                        ),
                        Text(
                          "Size:",
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: stockAda,
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          List snapData = snapshot.data! as List;

                          if (snapData[0] != 404) {
                            for (var element in snapData) {
                              if (element["nama_product"] == dropdownValue) {
                                print(element["ukuran"][0]["stock"]);
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("XS"),
                                        Spacer(),
                                        Text("Stock: "),
                                        Text(element["ukuran"][0]["stock"]
                                            .toString()),
                                        Spacer(),
                                        Container(
                                          width: 60.0,
                                          foregroundDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                              color: Colors.blueGrey,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(8.0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                  ),
                                                  controller: _controller,
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                    decimal: false,
                                                    signed: true,
                                                  ),
                                                  inputFormatters: <TextInputFormatter>[
                                                    MyFilter()
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 38.0,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            width: 0.5,
                                                          ),
                                                        ),
                                                      ),
                                                      child: InkWell(
                                                        child: Icon(
                                                          Icons.arrow_drop_up,
                                                          size: 18.0,
                                                        ),
                                                        onTap: () {
                                                          int currentValue =
                                                              int.parse(
                                                                  _controller
                                                                      .text);
                                                          setState(() {
                                                            currentValue++;
                                                            _controller.text =
                                                                (currentValue)
                                                                    .toString(); // incrementing value
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    InkWell(
                                                      child: Icon(
                                                        Icons.arrow_drop_down,
                                                        size: 18.0,
                                                      ),
                                                      onTap: () {
                                                        int currentValue =
                                                            int.parse(
                                                                _controller
                                                                    .text);
                                                        setState(() {
                                                          print(
                                                              "Setting state");
                                                          currentValue--;
                                                          _controller
                                                              .text = (currentValue >
                                                                      0
                                                                  ? currentValue
                                                                  : 0)
                                                              .toString(); // decrementing value
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          child: DropdownButton<String>(
                                            value: satuanValueXS,
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.deepPurple),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurple,
                                            ),
                                            onChanged: (String? value) {
                                              setState(() {
                                                satuanValueXS = value!;
                                              });
                                            },
                                            items: satuan
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("S"),
                                        Spacer(),
                                        Text("Stock: "),
                                        Text(element["ukuran"][1]["stock"]
                                            .toString()),
                                        Spacer(),
                                        Container(
                                          width: 60.0,
                                          foregroundDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                              color: Colors.blueGrey,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(8.0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                  ),
                                                  controller: _controller1,
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                    decimal: false,
                                                    signed: true,
                                                  ),
                                                  inputFormatters: <TextInputFormatter>[
                                                    MyFilter()
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 38.0,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            width: 0.5,
                                                          ),
                                                        ),
                                                      ),
                                                      child: InkWell(
                                                        child: Icon(
                                                          Icons.arrow_drop_up,
                                                          size: 18.0,
                                                        ),
                                                        onTap: () {
                                                          int currentValue =
                                                              int.parse(
                                                                  _controller1
                                                                      .text);
                                                          setState(() {
                                                            currentValue++;
                                                            _controller1.text =
                                                                (currentValue)
                                                                    .toString(); // incrementing value
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    InkWell(
                                                      child: Icon(
                                                        Icons.arrow_drop_down,
                                                        size: 18.0,
                                                      ),
                                                      onTap: () {
                                                        int currentValue =
                                                            int.parse(
                                                                _controller1
                                                                    .text);
                                                        setState(() {
                                                          print(
                                                              "Setting state");
                                                          currentValue--;
                                                          _controller1
                                                              .text = (currentValue >
                                                                      0
                                                                  ? currentValue
                                                                  : 0)
                                                              .toString(); // decrementing value
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          child: DropdownButton<String>(
                                            value: satuanValueS,
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.deepPurple),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurple,
                                            ),
                                            onChanged: (String? value) {
                                              setState(() {
                                                satuanValueS = value!;
                                              });
                                            },
                                            items: satuan
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("M"),
                                        Spacer(),
                                        Text("Stock: "),
                                        Text(element["ukuran"][2]["stock"]
                                            .toString()),
                                        Spacer(),
                                        Container(
                                          width: 60.0,
                                          foregroundDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                              color: Colors.blueGrey,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(8.0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                  ),
                                                  controller: _controller2,
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                    decimal: false,
                                                    signed: true,
                                                  ),
                                                  inputFormatters: <TextInputFormatter>[
                                                    MyFilter()
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 38.0,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            width: 0.5,
                                                          ),
                                                        ),
                                                      ),
                                                      child: InkWell(
                                                        child: Icon(
                                                          Icons.arrow_drop_up,
                                                          size: 18.0,
                                                        ),
                                                        onTap: () {
                                                          int currentValue =
                                                              int.parse(
                                                                  _controller2
                                                                      .text);
                                                          setState(() {
                                                            currentValue++;
                                                            _controller2.text =
                                                                (currentValue)
                                                                    .toString(); // incrementing value
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    InkWell(
                                                      child: Icon(
                                                        Icons.arrow_drop_down,
                                                        size: 18.0,
                                                      ),
                                                      onTap: () {
                                                        int currentValue =
                                                            int.parse(
                                                                _controller2
                                                                    .text);
                                                        setState(() {
                                                          print(
                                                              "Setting state");
                                                          currentValue--;
                                                          _controller2
                                                              .text = (currentValue >
                                                                      0
                                                                  ? currentValue
                                                                  : 0)
                                                              .toString(); // decrementing value
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          child: DropdownButton<String>(
                                            value: satuanValueM,
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.deepPurple),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurple,
                                            ),
                                            onChanged: (String? value) {
                                              setState(() {
                                                satuanValueM = value!;
                                              });
                                            },
                                            items: satuan
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("L"),
                                        Spacer(),
                                        Text("Stock: "),
                                        Text(element["ukuran"][3]["stock"]
                                            .toString()),
                                        Spacer(),
                                        Container(
                                          width: 60.0,
                                          foregroundDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                              color: Colors.blueGrey,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(8.0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                  ),
                                                  controller: _controller3,
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                    decimal: false,
                                                    signed: true,
                                                  ),
                                                  inputFormatters: <TextInputFormatter>[
                                                    MyFilter()
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 38.0,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            width: 0.5,
                                                          ),
                                                        ),
                                                      ),
                                                      child: InkWell(
                                                        child: Icon(
                                                          Icons.arrow_drop_up,
                                                          size: 18.0,
                                                        ),
                                                        onTap: () {
                                                          int currentValue =
                                                              int.parse(
                                                                  _controller3
                                                                      .text);
                                                          setState(() {
                                                            currentValue++;
                                                            _controller3.text =
                                                                (currentValue)
                                                                    .toString(); // incrementing value
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    InkWell(
                                                      child: Icon(
                                                        Icons.arrow_drop_down,
                                                        size: 18.0,
                                                      ),
                                                      onTap: () {
                                                        int currentValue =
                                                            int.parse(
                                                                _controller3
                                                                    .text);
                                                        setState(() {
                                                          print(
                                                              "Setting state");
                                                          currentValue--;
                                                          _controller3
                                                              .text = (currentValue >
                                                                      0
                                                                  ? currentValue
                                                                  : 0)
                                                              .toString(); // decrementing value
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          child: DropdownButton<String>(
                                            value: satuanValueL,
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.deepPurple),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurple,
                                            ),
                                            onChanged: (String? value) {
                                              setState(() {
                                                satuanValueL = value!;
                                              });
                                            },
                                            items: satuan
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("XL"),
                                        Spacer(),
                                        Text("Stock: "),
                                        Text(element["ukuran"][4]["stock"]
                                            .toString()),
                                        Spacer(),
                                        Container(
                                          width: 60.0,
                                          foregroundDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                              color: Colors.blueGrey,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(8.0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                  ),
                                                  controller: _controller4,
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                    decimal: false,
                                                    signed: true,
                                                  ),
                                                  inputFormatters: <TextInputFormatter>[
                                                    MyFilter()
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 38.0,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            width: 0.5,
                                                          ),
                                                        ),
                                                      ),
                                                      child: InkWell(
                                                        child: Icon(
                                                          Icons.arrow_drop_up,
                                                          size: 18.0,
                                                        ),
                                                        onTap: () {
                                                          int currentValue =
                                                              int.parse(
                                                                  _controller4
                                                                      .text);
                                                          setState(() {
                                                            currentValue++;
                                                            _controller4.text =
                                                                (currentValue)
                                                                    .toString(); // incrementing value
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    InkWell(
                                                      child: Icon(
                                                        Icons.arrow_drop_down,
                                                        size: 18.0,
                                                      ),
                                                      onTap: () {
                                                        int currentValue =
                                                            int.parse(
                                                                _controller4
                                                                    .text);
                                                        setState(() {
                                                          print(
                                                              "Setting state");
                                                          currentValue--;
                                                          _controller4
                                                              .text = (currentValue >
                                                                      0
                                                                  ? currentValue
                                                                  : 0)
                                                              .toString(); // decrementing value
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          child: DropdownButton<String>(
                                            value: satuanValueXL,
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.deepPurple),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurple,
                                            ),
                                            onChanged: (String? value) {
                                              setState(() {
                                                satuanValueXL = value!;
                                              });
                                            },
                                            items: satuan
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("XXL"),
                                        Spacer(),
                                        Text("Stock: "),
                                        Text(element["ukuran"][5]["stock"]
                                            .toString()),
                                        Spacer(),
                                        Container(
                                          width: 60.0,
                                          foregroundDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                              color: Colors.blueGrey,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(8.0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                  ),
                                                  controller: _controller5,
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                    decimal: false,
                                                    signed: true,
                                                  ),
                                                  inputFormatters: <TextInputFormatter>[
                                                    MyFilter()
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 38.0,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            width: 0.5,
                                                          ),
                                                        ),
                                                      ),
                                                      child: InkWell(
                                                        child: Icon(
                                                          Icons.arrow_drop_up,
                                                          size: 18.0,
                                                        ),
                                                        onTap: () {
                                                          int currentValue =
                                                              int.parse(
                                                                  _controller5
                                                                      .text);
                                                          setState(() {
                                                            currentValue++;
                                                            _controller5.text =
                                                                (currentValue)
                                                                    .toString(); // incrementing value
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    InkWell(
                                                      child: Icon(
                                                        Icons.arrow_drop_down,
                                                        size: 18.0,
                                                      ),
                                                      onTap: () {
                                                        int currentValue =
                                                            int.parse(
                                                                _controller5
                                                                    .text);
                                                        setState(() {
                                                          print(
                                                              "Setting state");
                                                          currentValue--;
                                                          _controller5
                                                              .text = (currentValue >
                                                                      0
                                                                  ? currentValue
                                                                  : 0)
                                                              .toString(); // decrementing value
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          child: DropdownButton<String>(
                                            value: satuanValueXXl,
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.deepPurple),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurple,
                                            ),
                                            onChanged: (String? value) {
                                              setState(() {
                                                satuanValueXXl = value!;
                                              });
                                            },
                                            items: satuan
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 15, 0, 15),
                                          child: ElevatedButton(
                                            style: TextButton.styleFrom(
                                              //primary: Colors.white,
                                              backgroundColor: cancel,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 20),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddBarangTransaksi()));
                                            },
                                            child: Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Text(
                                                  "Cancel",
                                                  style: GoogleFonts.inter(
                                                    color: lightText,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 15,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 15, 0, 15),
                                          child: ElevatedButton(
                                            style: TextButton.styleFrom(
                                              //primary: Colors.white,
                                              backgroundColor: navbar,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 20),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {
                                              _showConfirmationDialog(context)
                                                  .then((value) {
                                                Navigator.of(this.context)
                                                    .pop();
                                              });
                                            },
                                            child: Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Text(
                                                  "Tambah",
                                                  style: GoogleFonts.inter(
                                                    color: lightText,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 15,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                return Text("Select items First");
                              }
                            }
                          } else {
                            return Text("Select items First");
                          }
                        } else {
                          return Text("Select items First");
                        }
                        return Text("Select items First");
                      })),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}

Future<void> _showConfirmationDialog(BuildContext context) async {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Confirmation?",
          ),
          actions: [
            TextButton(
              child: Text("cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("confirm"),
              onPressed: () {
                detailOrder.add(DetailOrder(
                    idDetailOrder: 1,
                    namaBarang: "Polo - Short - Blue",
                    jumlah: 20,
                    satuan: "pcs",
                    hargaJual: 54000,
                    subTotal: 1800000,
                    detailOrderBarang: detailOrderBarang));
                Navigator.of(context).pop();
              },
            ),
          ],
          content: Text(
            "are you sure?",
          ),
        );
      }).whenComplete(() {
    setState() {}
  });
}

class MyFilter extends TextInputFormatter {
  static final _reg = RegExp(r'^\d+$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return _reg.hasMatch(newValue.text) ? newValue : oldValue;
  }
}
