import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sales/add_barang.dart';
import 'package:sales/themes/colors.dart';

import 'package:dropdown_search/dropdown_search.dart';

class DetailRetur extends StatefulWidget {
  const DetailRetur({super.key});

  @override
  State<DetailRetur> createState() => _DetailReturState();
}

class _DetailReturState extends State<DetailRetur> {
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
                    "Detail Retur",
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
                child: Column(children: [
                  Container(
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
                                    children: [
                                      Text(
                                        "Arteast",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26),
                                      ),
                                      Text(
                                        "Madiun",
                                        style: TextStyle(),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    "20 Pcs",
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
                                    Text("abc")
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  children: [
                                    Text("Total",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Spacer(),
                                    Text("abc")
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Sales",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Text("abc")
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
                                  color: cancel,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "Retur",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
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
                            Text("Tanggal Retur"),
                            Spacer(),
                            Text("14-08-2023"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Tipe Pembayaran"),
                            Spacer(),
                            Text("Credit"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Tanggal Pembayaran"),
                            Spacer(),
                            Text("15-08.2023"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Sales"),
                            Spacer(),
                            Text("Yong"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Retur"),
                            Spacer(),
                            Text("Rp. 0"),
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 15, 10, 0),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        color: navbar,
                                      ),
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  "Nama Barang",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 11,
                                                      color: lightText,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Center(
                                                  child: Text(
                                                    "Jumlah/pcs",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 11,
                                                        color: lightText,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Center(
                                                  child: Text(
                                                    "Harga",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 11,
                                                        color: lightText,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "Total Harga",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 11,
                                                        color: lightText,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      controller: ScrollController(),
                                      physics: const ClampingScrollPhysics(),
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddBarangTransaksi()));
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: const BorderSide(
                                                color: Colors.transparent,
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
                                                    "Barang aaaa",
                                                    style: GoogleFonts.inter(
                                                      color: darkText,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Center(
                                                    child: Text(
                                                      "5",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.inter(
                                                        color: darkText,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Center(
                                                    child: Text(
                                                      "Rp. 50.000",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.inter(
                                                        color: darkText,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "Rp. 250.000",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.inter(
                                                        color: darkText,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                          ),
                                        );
                                      },
                                    ),
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
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
