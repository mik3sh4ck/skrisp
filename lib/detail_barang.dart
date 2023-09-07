import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sales/detail_transaksi.dart';
import 'package:sales/themes/colors.dart';

import 'package:dropdown_search/dropdown_search.dart';

var _currencies = [
  " ",
  "Food",
  "Transport",
  "Personal",
  "Shopping",
  "Medical",
  "Rent",
  "Movie",
  "Salary"
];

class DetailBarangTransaksi extends StatefulWidget {
  const DetailBarangTransaksi({super.key});

  @override
  State<DetailBarangTransaksi> createState() => _DetailBarangTransaksi();
}

class _DetailBarangTransaksi extends State<DetailBarangTransaksi> {
  TextEditingController _controller = TextEditingController();
  String dropdownValue = _currencies.first;
  @override
  void initState() {
    super.initState();
    _controller.text = "0";
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
                        DropdownMenu<String>(
                          width: MediaQuery.of(context).size.width - 40,
                          initialSelection: _currencies.first,
                          onSelected: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          dropdownMenuEntries: _currencies
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
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
                      ],
                    ),
                  ),
                  Text("Size:"),
                  Row(
                    children: [
                      Text("XS"),
                      Text("Stock: "),
                      Text("20 pcs"),
                      Container(
                        width: 60.0,
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
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
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                controller: _controller,
                                keyboardType: TextInputType.numberWithOptions(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                            int.parse(_controller.text);
                                        setState(() {
                                          currentValue++;
                                          _controller.text = (currentValue)
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
                                          int.parse(_controller.text);
                                      setState(() {
                                        print("Setting state");
                                        currentValue--;
                                        _controller.text = (currentValue > 0
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
                    ],
                  ),
                  Row(
                    children: [
                      Text("XS"),
                      Text("Stock: "),
                      Text("20 pcs"),
                      Container(
                        width: 60.0,
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
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
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                controller: _controller,
                                keyboardType: TextInputType.numberWithOptions(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                            int.parse(_controller.text);
                                        setState(() {
                                          currentValue++;
                                          _controller.text = (currentValue)
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
                                          int.parse(_controller.text);
                                      setState(() {
                                        print("Setting state");
                                        currentValue--;
                                        _controller.text = (currentValue > 0
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
                    ],
                  ),
                  Row(
                    children: [
                      Text("XS"),
                      Text("Stock: "),
                      Text("20 pcs"),
                      Container(
                        width: 60.0,
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
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
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                controller: _controller,
                                keyboardType: TextInputType.numberWithOptions(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                            int.parse(_controller.text);
                                        setState(() {
                                          currentValue++;
                                          _controller.text = (currentValue)
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
                                          int.parse(_controller.text);
                                      setState(() {
                                        print("Setting state");
                                        currentValue--;
                                        _controller.text = (currentValue > 0
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
                    ],
                  ),
                  Row(
                    children: [
                      Text("XS"),
                      Text("Stock: "),
                      Text("20 pcs"),
                      Container(
                        width: 60.0,
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
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
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                controller: _controller,
                                keyboardType: TextInputType.numberWithOptions(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                            int.parse(_controller.text);
                                        setState(() {
                                          currentValue++;
                                          _controller.text = (currentValue)
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
                                          int.parse(_controller.text);
                                      setState(() {
                                        print("Setting state");
                                        currentValue--;
                                        _controller.text = (currentValue > 0
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
                    ],
                  ),
                  Row(
                    children: [
                      Text("XS"),
                      Text("Stock: "),
                      Text("20 pcs"),
                      Container(
                        width: 60.0,
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
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
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                controller: _controller,
                                keyboardType: TextInputType.numberWithOptions(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                            int.parse(_controller.text);
                                        setState(() {
                                          currentValue++;
                                          _controller.text = (currentValue)
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
                                          int.parse(_controller.text);
                                      setState(() {
                                        print("Setting state");
                                        currentValue--;
                                        _controller.text = (currentValue > 0
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
                    ],
                  ),
                  Row(
                    children: [
                      Text("XS"),
                      Spacer(),
                      Text("Stock: "),
                      Spacer(),
                      Text("20 pcs"),
                      Spacer(),
                      Container(
                        width: 60.0,
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
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
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                controller: _controller,
                                keyboardType: TextInputType.numberWithOptions(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                            int.parse(_controller.text);
                                        setState(() {
                                          currentValue++;
                                          _controller.text = (currentValue)
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
                                          int.parse(_controller.text);
                                      setState(() {
                                        print("Setting state");
                                        currentValue--;
                                        _controller.text = (currentValue > 0
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
                    ],
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}

class MyFilter extends TextInputFormatter {
  static final _reg = RegExp(r'^\d+$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return _reg.hasMatch(newValue.text) ? newValue : oldValue;
  }
}
