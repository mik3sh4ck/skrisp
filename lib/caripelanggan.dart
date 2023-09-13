import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales/detail_transaksi.dart';
import 'package:sales/global.dart';
import 'package:sales/models/apis.dart';
import 'package:sales/nearbyresponse.dart';

import '../themes/colors.dart';

import 'package:intl/intl.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'dart:math' show asin, atan2, cos, pi, pow, sin, sqrt;

String _idCat = "";
String alamat = "";
bool searched = false;
Timer? timer;
ServicesUser servicesUser = ServicesUser();

class CariPelangganPage extends StatefulWidget {
  const CariPelangganPage({super.key});

  @override
  State<CariPelangganPage> createState() => _CariPelangganPageState();
}

class _CariPelangganPageState extends State<CariPelangganPage> {
  var gmapKey = "AIzaSyCevGSYN9v8XTqy1gUAdrc7jId3XsCYgTM";

  late final GoogleMapController? mapController;

  LatLng currentLocation = const LatLng(0.0, 0.0);

  LatLng destinationLocation = const LatLng(0.0, 0.0);

  LatLng tapLocation = const LatLng(0.0, 0.0);
  Set<Marker> locationsMark = new Set();

  Marker currentMarker = const Marker(
    markerId: MarkerId('current_marker'),
  );
  Marker destinationMarker = const Marker(
    markerId: MarkerId('destination_marker'),
  );

  Set<Polyline> polylines = <Polyline>{};

  final _controllerRadius = TextEditingController();
  String radiusdikirim = "0";
  nerbyplacesjson nearbyPlacesResponse = nerbyplacesjson();
  Results nearbyPlaceResults = Results();

  Future<void> locationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      openAppSettings();
    } else if (status.isGranted) {
      return;
    }
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    await locationPermission();

    final position = await Geolocator.getCurrentPosition();

    currentLocation = LatLng(position.latitude, position.longitude);
    //destinationLocation = const LatLng(-7.276023, 112.782217);

    destinationMarker = Marker(
      markerId: const MarkerId('destination_marker'),
      position: destinationLocation,
    );

    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: currentLocation,
          zoom: 20,
        ),
      ),
    );

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      ),
    ).listen((event) {
      currentLocation = LatLng(event.latitude, event.longitude);
      //ini masukno api buat mawsuk ke db

      timer = Timer.periodic(
          Duration(seconds: 15),
          (Timer t) => servicesUser.updateLocation(
              event.latitude, event.longitude, idUser));
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    final apiKey = gmapKey; // Ganti dengan kunci API Google Maps Anda

    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResult = json.decode(response.body);
      final results = jsonResult['results'];
      if (results != null && results.isNotEmpty) {
        final addressComponents = results[0]['address_components'];
        List<String> addressParts = [];
        for (var component in addressComponents) {
          addressParts.add(component['long_name']);
        }
        String address = addressParts.join(', ');
        alamat = "a";
        return address;
      }
    }

    return alamat;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
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
                  "Cari Pelanggan",
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
      extendBody: true,
      body: SizedBox(
        width: deviceSize.width,
        height: deviceSize.height,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    circles: Set<Circle>.of([
                      Circle(
                          strokeWidth: 2,
                          fillColor: Colors.black.withOpacity(0.2),
                          circleId: CircleId('radius'),
                          center: tapLocation,
                          radius: double.parse(radiusdikirim))
                    ]),
                    onTap: (argument) async {
                      tapLocation =
                          LatLng(argument.latitude, argument.longitude);
                      if (mounted) setState(() {});

                      String address = await getAddressFromLatLng(
                          tapLocation.latitude, tapLocation.longitude);
                      print(address);

                      debugPrint(argument.latitude.toString());
                      debugPrint(argument.longitude.toString());
                    },
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    buildingsEnabled: true,
                    onMapCreated: onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: currentLocation,
                      zoom: 20,
                    ),
                    markers: locationsMark,
                    polylines: polylines.toSet(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: searched
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: nearbyPlacesResponse.results != null
                            ? Container(
                                child: Column(
                                children: [
                                  ElevatedButton(
                                    style: TextButton.styleFrom(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 17, 30, 17),
                                      backgroundColor: navbar,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      searched = false;
                                      locationsMark = new Set();
                                      setState(() {});
                                    },
                                    child: Text(
                                      "Search",
                                      style: GoogleFonts.notoSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    controller: ScrollController(),
                                    physics: const ClampingScrollPhysics(),
                                    itemCount:
                                        nearbyPlacesResponse.results!.length,
                                    itemBuilder: (context, index) {
                                      locationsMark.add(Marker(
                                        markerId: MarkerId(nearbyPlacesResponse
                                            .results![index].name
                                            .toString()),
                                        position: LatLng(
                                            nearbyPlacesResponse.results![index]
                                                .geometry!.location!.lat!
                                                .toDouble(),
                                            nearbyPlacesResponse.results![index]
                                                .geometry!.location!.lng!
                                                .toDouble()),
                                        infoWindow: InfoWindow(
                                            title: nearbyPlacesResponse
                                                .results![index].name
                                                .toString()),
                                        icon: BitmapDescriptor
                                            .defaultMarkerWithHue(
                                                BitmapDescriptor.hueViolet),
                                      ));
                                      return nearbyPlacesWidget(
                                          nearbyPlacesResponse.results![index]);
                                    },
                                  ),
                                ],
                              ))
                            : Column(
                                children: [
                                  Text("No data"),
                                  ElevatedButton(
                                    style: TextButton.styleFrom(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 17, 30, 17),
                                      backgroundColor: navbar,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      locationsMark = new Set();
                                      searched = false;
                                      setState(() {});
                                    },
                                    child: Text(
                                      "Search",
                                      style: GoogleFonts.notoSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                "Radius",
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: TextField(
                                      readOnly: false,
                                      controller: _controllerRadius,
                                      showCursor: true,
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintStyle: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 10),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            width: 1.5,
                                            color: Colors.black,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "M",
                                        style: TextStyle(
                                          color: darkText,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 50),
                            Center(
                              child: ElevatedButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.fromLTRB(30, 17, 30, 17),
                                  backgroundColor: navbar,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  radiusdikirim = _controllerRadius.text;
                                  searched = true;
                                  getNearbyPlaces();
                                  setState(() {});
                                },
                                child: Text(
                                  "Search",
                                  style: GoogleFonts.notoSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void getNearbyPlaces() async {
    var url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" +
            currentLocation.latitude.toString() +
            "," +
            currentLocation.longitude.toString() +
            "&radius=" +
            radiusdikirim +
            "&key=AIzaSyCevGSYN9v8XTqy1gUAdrc7jId3XsCYgTM&types=clothing_store");

    var response = await http.post(url);
    print(response.body);

    nearbyPlacesResponse = nerbyplacesjson.fromJson(jsonDecode(response.body));
    if (mounted) setState(() {});
  }

  Widget nearbyPlacesWidget(Results result) {
    final double latbox = result.geometry!.location!.lat!.toDouble();
    final double lngbox = result.geometry!.location!.lng!.toDouble();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _gotolocation(latbox, lngbox);
                    },
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              result.name!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 26),
                            ),
                            Text(
                              result.vicinity!,
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                            builder: (context) => DetailTransaksi(
                                  id_transaksi: 7,
                                )));
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
      ),
    );
  }

  Future<void> _gotolocation(double lat, double lng) async {
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, lng), zoom: 30, tilt: 50.0, bearing: 45.0)));
  }
}
