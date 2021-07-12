//import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:network_http/Pages/EProdects.dart';
import 'package:network_http/Pages/Homepage.dart';
import 'package:network_http/Pages/ProdectInf.dart';
import 'package:network_http/Pages/TestScrren.dart';
import 'package:network_http/Pages/ViewOrderAdmain.dart';
import 'package:network_http/Pages/signupSceen.dart';
import 'package:network_http/Pages/EditProdects.dart';
import 'package:network_http/Provider/Cartitem.dart';
import 'package:provider/provider.dart';
import 'Pages/AddProdectPage.dart';
import 'Pages/Admin.dart';
import 'Pages/CartScreen.dart';
import 'Pages/LoginScreen.dart';
import 'Provider/Admin.dart';
import 'Provider/Mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModalHub>(
          create: (context) => ModalHub(),
        ),
        ChangeNotifierProvider<AdmainProvder>(
          create: (context) => AdmainProvder(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.route,
        routes: {
          ViewOrder.id: (context) => ViewOrder(),
          TestScrren.id: (context) => TestScrren(),
          Cart.id: (context) => Cart(),
          ProdectInfo.id: (context) => ProdectInfo(),
          LoginScreen.route: (context) => LoginScreen(),
          'SignUpScreen': (context) => SignUpScreen(),
          'AdminPage': (context) => AdminPage(),
          HomePage.route: (context) => HomePage(),
          AddProdect.id: (context) => AddProdect(),
          EditProdect.id: (context) => EditProdect(),
          EProdect.id: (context) => EProdect(),
        },
      ),
    );
  }
}
