import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sales/add_barang.dart';
import 'package:sales/detail_barang.dart';
import 'package:sales/themes/colors.dart';

import 'package:dropdown_search/dropdown_search.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  DateTime _selectedDate2 = DateTime.now();
  String _formattedDate2 = "";
  String _date2 = "";

  DateTime _selectedDate3 = DateTime.now();
  String _formattedDate3 = "";
  String _date3 = "";

  String selectedIdPenawaran = "";

  Future<void> selectFilterDate2(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate2,
      firstDate: _selectedDate2,
      lastDate: _selectedDate2.add(Duration(days: 6)),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: navbar, // header background color
                onPrimary: lightText, // header text color
                onSurface: darkText, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: navbar, // button text color
                ),
              ),
            ),
            child: child!);
      },
    );
    if (picked != null && picked != _selectedDate2) {
      if (mounted) {
        _selectedDate2 = picked;
        _formattedDate2 = DateFormat('dd-MM-yyyy').format(_selectedDate2);
        _date2 = _formattedDate2;
        setState(() {});
      }
    }
  }

  Future<void> selectFilterDate3(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate3,
      firstDate: _selectedDate3,
      lastDate: _selectedDate3.add(Duration(days: 6)),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: navbar, // header background color
                onPrimary: lightText, // header text color
                onSurface: darkText, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: navbar, // button text color
                ),
              ),
            ),
            child: child!);
      },
    );
    if (picked != null && picked != _selectedDate3) {
      if (mounted) {
        _selectedDate3 = picked;
        _formattedDate3 = DateFormat('dd-MM-yyyy').format(_selectedDate3);
        _date3 = _formattedDate3;
        setState(() {});
      }
    }
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
                    "Add Order",
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
          //width: deviceWidth,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse
            }),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15, right: 15, left: 15, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Pelanggan",
                        style: TextStyle(
                          color: darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              style: BorderStyle.none,
                              color: darkText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Tanggal Pesanan",
                        style: TextStyle(
                          color: darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () {
                          selectFilterDate2(context)
                              .then((value) => setState(() {}));
                          _selectedDate2 = DateTime.now();
                          _date2 = "";
                        },
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: darkText, width: 1),
                            color: lightText,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _date2,
                                style: TextStyle(
                                  color: darkText,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Icon(Icons.calendar_month),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "No Order",
                        style: TextStyle(
                          color: darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              style: BorderStyle.none,
                              color: darkText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Masukkan Barang",
                        style: TextStyle(
                          color: darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
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
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    color: navbar,
                                  ),
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: Text(
                                                "Jumlah",
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
                                              alignment: Alignment.centerRight,
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
                                                    DetailBarangTransaksi()));
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                "Barang aaaa",
                                                style: GoogleFonts.inter(
                                                  color: darkText,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Center(
                                                child: Text(
                                                  "5",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.inter(
                                                    color: darkText,
                                                    fontWeight: FontWeight.w500,
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
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.inter(
                                                    color: darkText,
                                                    fontWeight: FontWeight.w500,
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
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.inter(
                                                    color: darkText,
                                                    fontWeight: FontWeight.w500,
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
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                      //primary: Colors.white,
                                      backgroundColor: navbar,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Pembayaran",
                        style: TextStyle(
                          color: darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: DropdownSearch<String>(
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            textAlign: TextAlign.left,
                            dropdownSearchDecoration: InputDecoration(
                              filled: true,
                              fillColor: lightText,
                              iconColor: darkText,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: darkText,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: darkText,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: darkText,
                                ),
                              ),
                            )),
                        popupProps: const PopupProps.menu(
                          fit: FlexFit.loose,
                          showSelectedItems: false,
                          menuProps: MenuProps(
                            backgroundColor: Color(0xffE5E5E5),
                          ),
                        ),
                        items: ["Cash", "Credit"],
                        onChanged: (val) {
                          selectedIdPenawaran = val!;
                          setState(() {});
                        },
                        selectedItem: selectedIdPenawaran,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Down Payment",
                        style: TextStyle(
                          color: darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              style: BorderStyle.none,
                              color: darkText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Tanggal Pesanan",
                        style: TextStyle(
                          color: darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () {
                          selectFilterDate3(context)
                              .then((value) => setState(() {}));
                          _selectedDate3 = DateTime.now();
                          _date3 = "";
                        },
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: darkText, width: 1),
                            color: lightText,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _date3,
                                style: TextStyle(
                                  color: darkText,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Icon(Icons.calendar_month),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Catatan",
                        style: TextStyle(
                          color: darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              style: BorderStyle.none,
                              color: darkText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: TextButton.styleFrom(
                              //primary: Colors.white,
                              backgroundColor: cancel,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  "Cancel",
                                  style: GoogleFonts.inter(
                                    color: lightText,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 15),
                          ElevatedButton(
                            style: TextButton.styleFrom(
                              //primary: Colors.white,
                              backgroundColor: navbar,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  "Confirm",
                                  style: GoogleFonts.inter(
                                    color: lightText,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
