import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:animations/animations.dart';

import 'package:intl/intl.dart';
import 'package:sales/add_order.dart';
import 'package:sales/home.dart';
import 'package:sales/login.dart';
import 'package:sales/themes/colors.dart';
import 'package:sales/transaksi.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CITY CINEMAS",
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 2460,
        minWidth: 480,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K")
        ],
        background: Container(
          color: const Color(0xFFF5F5F5),
        ),
      ),
      theme: ThemeData().copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.windows: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.horizontal),
          },
        ),
      ),
      home: const AuthPage(),
    ),
  );
}

class UserAuth with ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void setIsLoggedIn(val) {
    _isLoggedIn = val;
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Home1(),
    //Ticket1(),
    AddOrder(),
    Transaksi(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
        color: lightText,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          //app bar
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: BottomNavigationBar(
                iconSize: 35,
                backgroundColor: navbar,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.task),
                    label: 'Task',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: lightText,
                unselectedItemColor: darkText,
                onTap: _onItemTapped,
              ),
            ),
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
        ));
  }
}
