import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sales/add_order.dart';
import 'package:sales/caripelanggan.dart';
import 'package:sales/detail_transaksi.dart';
import 'package:sales/global.dart';
import 'package:sales/themes/colors.dart';

import 'package:dropdown_search/dropdown_search.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  late Future listTransaksi;

  @override
  void initState() {
    listTransaksi = servicesUser.showHeaderOrder(idUser);
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
                    "Transaksi",
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
            future: listTransaksi,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                List snapData = snapshot.data! as List;
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
                            kota: snapData[index]["kota"],
                            totalBarang: snapData[index]["total_barang"],
                            noOrder: snapData[index]["no_order"],
                            SubTotal: snapData[index]["sub_total"].toString(),
                            NamaSales: snapData[index]["nama_sales"],
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
  final String kota;
  final String totalBarang;
  final String noOrder;
  final String SubTotal;
  final String NamaSales;
  const TransactionBox(
      {super.key,
      required this.nama_toko,
      required this.kota,
      required this.totalBarang,
      required this.noOrder,
      required this.SubTotal,
      required this.NamaSales});

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
                          "${this.nama_toko}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26),
                        ),
                        Text(
                          "${this.kota}",
                          style: TextStyle(),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      "14-09-2023",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "${this.totalBarang} Pcs",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                Divider(color: Colors.black),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Text("No Order",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text("${noOrder}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    children: [
                      Text("Total",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text("Rp. ${SubTotal}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    children: [
                      Text(
                        "Sales",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text("${NamaSales}")
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Row(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "New",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
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
