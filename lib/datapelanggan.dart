import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sales/add_order.dart';
import 'package:sales/caripelanggan.dart';
import 'package:sales/detail_transaksi.dart';
import 'package:sales/themes/colors.dart';

import 'package:dropdown_search/dropdown_search.dart';

class DataPelanggan extends StatefulWidget {
  const DataPelanggan({super.key});

  @override
  State<DataPelanggan> createState() => _DataPelangganState();
}

class _DataPelangganState extends State<DataPelanggan> {
  late Future listPelanggan;

  @override
  void initState() {
    listPelanggan = servicesUser.showPelanggan();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => AddOrder())));
          },
          child: const Icon(Icons.add),
        ),
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
                    "Data Pelanggan",
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
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: listPelanggan,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                List snapData = snapshot.data! as List;
                print(snapData);
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapData.length,
                        itemBuilder: (context, index) {
                          return TransactionBox(
                            nama_toko: snapData[index]["nama_toko"],
                            no_telp: snapData[index]["no_telp"],
                            Alamat: snapData[index]["alamat"],
                            NamaPenanggunJawab: snapData[index]
                                ["nama_penanggungjawab"],
                            kota: snapData[index]["kota"],
                            provinsi: snapData[index]["provinsi"],
                          );
                        }),
                  ),
                );
              }
              return const CircularProgressIndicator();
            }),
          ),
        ),
      ),
    );
  }
}

class TransactionBox extends StatelessWidget {
  final String nama_toko;
  final String no_telp;
  final String Alamat;
  final String kota;
  final String provinsi;
  final String NamaPenanggunJawab;
  const TransactionBox(
      {super.key,
      required this.nama_toko,
      required this.no_telp,
      required this.Alamat,
      required this.NamaPenanggunJawab,
      required this.kota,
      required this.provinsi});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 15,
                spreadRadius: 2,
                offset: Offset(5.0, 5.0))
          ]),
      width: 500,
      height: 200,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${nama_toko}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26),
                        ),
                        Text(
                          "${Alamat}, ${kota}, ${provinsi}",
                          style: TextStyle(),
                        ),
                        Text(
                          "${no_telp}",
                          style: TextStyle(),
                        ),
                        Text(
                          "${NamaPenanggunJawab}",
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Row(
            children: [
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailTransaksi()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Detail",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
