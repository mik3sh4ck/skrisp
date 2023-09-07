import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales/add_order.dart';
import 'package:sales/caripelanggan.dart';
import 'package:sales/datapelanggan.dart';
import 'package:sales/detail_barang.dart';
import 'package:sales/detail_transaksi.dart';
import 'package:sales/login.dart';
import 'package:sales/retur.dart';
import 'package:sales/themes/colors.dart';
import 'package:sales/trackingSales.dart';
import 'package:sales/transaksi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      color: lightText,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: lightText,
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Admin",
                      style: GoogleFonts.oxygen(
                          fontSize: 17,
                          color: darkText,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Welcome To Your Home",
                      style: GoogleFonts.oxygen(
                          fontSize: 13,
                          color: darkText,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(cancel)),
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool("isLoggedInAdmin", false);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AuthPage()));
                  },
                  child: Text("Logout"),
                )
              ],
            ),
          ),
        ),
        body: Container(
          color: lightText,
          //width: deviceWidth,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse
            }),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CariPelangganPage(),
                                ),
                              ).whenComplete(() => setState(() {}));
                            },
                            child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: lightText,
                                  border: Border.all(color: darkText, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Order",
                                      style: GoogleFonts.oxygen(
                                          fontSize: 27,
                                          color: darkText,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "25",
                                      style: GoogleFonts.oxygen(
                                          fontSize: 35,
                                          color: darkText,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        RoundedButtonWithIconAndText(
                          iconPlace: "abc",
                          text: "Data Pelanggan",
                          routePage: DataPelanggan(),
                        ),
                        RoundedButtonWithIconAndText(
                          iconPlace: "abc",
                          text: "Cari Pelanggan",
                          routePage: CariPelangganPage(),
                        ),
                        RoundedButtonWithIconAndText(
                          iconPlace: "abc",
                          text: "Pesanan",
                          routePage: Transaksi(),
                        ),
                        RoundedButtonWithIconAndText(
                          iconPlace: "abc",
                          text: "History Transaksi",
                          routePage: Transaksi(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        RoundedButtonWithIconAndText(
                          iconPlace: "abc",
                          text: "Laporan",
                          routePage: Transaksi(),
                        ),
                        RoundedButtonWithIconAndText(
                          iconPlace: "abc",
                          text: "Stock",
                          routePage: DetailBarangTransaksi(),
                        ),
                        RoundedButtonWithIconAndText(
                          iconPlace: "abc",
                          text: "Pesanan",
                          routePage: Transaksi(),
                        ),
                        RoundedButtonWithIconAndText(
                          iconPlace: "abc",
                          text: "Retur",
                          routePage: Retur(),
                        ),
                        RoundedButtonWithIconAndText(
                          iconPlace: "abc",
                          text: "Tracking Sales",
                          routePage: CariSalesPage(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedButtonWithIconAndText extends StatelessWidget {
  final String iconPlace;
  final String text;
  final StatefulWidget routePage;

  const RoundedButtonWithIconAndText(
      {super.key,
      required this.iconPlace,
      required this.text,
      required this.routePage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => routePage));
          },
          child: Icon(Icons.menu, color: Colors.white),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.red,
          ),
        ),
        Text(text),
      ],
    );
  }
}
