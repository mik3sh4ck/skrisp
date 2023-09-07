import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sales/add_order.dart';
import 'package:sales/detail_retur.dart';
import 'package:sales/detail_transaksi.dart';
import 'package:sales/themes/colors.dart';

import 'package:dropdown_search/dropdown_search.dart';

class Retur extends StatefulWidget {
  const Retur({super.key});

  @override
  State<Retur> createState() => _ReturState();
}

class _ReturState extends State<Retur> {
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
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(this.context);
                    },
                    child: Align(
                      alignment: Alignment.bottomLeft,
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
                    "Retur",
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
          color: lightText,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse
            }),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15, right: 15, left: 15, bottom: 50),
                child: Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    controller: ScrollController(),
                    physics: const ClampingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return TransactionBox();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionBox extends StatelessWidget {
  const TransactionBox({
    super.key,
  });

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
                      children: [
                        Text(
                          "Arteast",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26),
                        ),
                        Text(
                          "Madiun",
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
                      "20 Pcs",
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
                      Text("abc")
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
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailRetur()));
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
