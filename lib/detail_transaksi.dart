import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sales/add_barang.dart';
import 'package:sales/caripelanggan.dart';
import 'package:sales/themes/colors.dart';

import 'package:dropdown_search/dropdown_search.dart';

class DetailTransaksi extends StatefulWidget {
  final int id_transaksi;

  const DetailTransaksi({super.key, required this.id_transaksi});

  @override
  State<DetailTransaksi> createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {
  late Future getDataTransaksi;
  late Future getBarangTransaksi;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataTransaksi = servicesUser.showOrderDetail(widget.id_transaksi);
    getBarangTransaksi =
        servicesUser.showOrderDetailBarangOnly(widget.id_transaksi);
    print(getBarangTransaksi);
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
                    "Detail Transaksi",
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
              padding: const EdgeInsets.only(
                  top: 15, right: 20, left: 20, bottom: 50),
              child: Center(
                child: FutureBuilder(
                  future: getDataTransaksi,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List snapData = snapshot.data! as List;

                      return Column(children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                                          children: [
                                            Text(
                                              "${snapData[0]['nama_toko']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 26),
                                            ),
                                            Text(
                                              "${snapData[0]['alamat']}, ${snapData[0]['kota']}",
                                              style: TextStyle(),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Text(
                                          "${snapData[0]['total_barang']} Pcs",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
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
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Spacer(),
                                          Text("${snapData[0]['no_order']}")
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: Row(
                                        children: [
                                          Text("Total",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Spacer(),
                                          Text("${snapData[0]['sub_total']}")
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Sales",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          Text("${snapData[0]['nama_sales']}")
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Tanggal Pemesanan"),
                                  Spacer(),
                                  Text("${snapData[0]['tanggal_pesanan']}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Tanggal Pengiriman"),
                                  Spacer(),
                                  Text("${snapData[0]['tanggal_pengiriman']}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Tipe Pembayaran"),
                                  Spacer(),
                                  Text("${snapData[0]['pembayaran']}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Tanggal Pembayaran"),
                                  Spacer(),
                                  Text("${snapData[0]['tanggal_pembayaran']}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Sales"),
                                  Spacer(),
                                  Text("${snapData[0]['nama_sales']}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Total"),
                                  Spacer(),
                                  Text("Rp. ${snapData[0]['sub_total']}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Retur"),
                                  Spacer(),
                                  Text("Rp. ${snapData[0]['retur']}"),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: SizedBox(
                                  child: Card(
                                    color: const Color(0xffF0F0F0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: const BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 15, 10, 0),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              color: navbar,
                                            ),
                                            padding: EdgeInsets.fromLTRB(
                                                20, 10, 20, 10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: Text(
                                                        "Nama Barang",
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontSize: 11,
                                                                color:
                                                                    lightText,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Center(
                                                        child: Text(
                                                          "Jumlah/pcs",
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 11,
                                                                  color:
                                                                      lightText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Center(
                                                        child: Text(
                                                          "Harga",
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 11,
                                                                  color:
                                                                      lightText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          "Total Harga",
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 11,
                                                                  color:
                                                                      lightText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          FutureBuilder(
                                              future: getBarangTransaksi,
                                              builder: (context, snapshot1) {
                                                if (snapshot1.hasData) {
                                                  List barang =
                                                      snapshot1.data! as List;
                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    controller:
                                                        ScrollController(),
                                                    physics:
                                                        const ClampingScrollPhysics(),
                                                    itemCount: barang.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          AddBarangTransaksi()));
                                                        },
                                                        child: Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            side:
                                                                const BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                            ),
                                                          ),
                                                          color: lightText,
                                                          //masih ada masalah di title card
                                                          child: ListTile(
                                                              title: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                flex: 5,
                                                                child: Text(
                                                                  "${barang[index]['Nama_barang']}",
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    color:
                                                                        darkText,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        11,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Center(
                                                                  child: Text(
                                                                    "${barang[index]['jumlah']}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts
                                                                        .inter(
                                                                      color:
                                                                          darkText,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          11,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child: Center(
                                                                  child: Text(
                                                                    "${barang[index]['harga_jual']}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts
                                                                        .inter(
                                                                      color:
                                                                          darkText,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          11,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: Text(
                                                                    "${barang[index]['sub_total']}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts
                                                                        .inter(
                                                                      color:
                                                                          darkText,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          11,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  return Text("no Data");
                                                }
                                              }),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]);
                    } else {
                      return Text("Data not found");
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
