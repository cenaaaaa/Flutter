import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import des pages pour les routes

import 'login_page.dart';
import 'home_page.dart';
import 'account_page.dart';
import 'app_bar.dart';
import 'listproduct_page.dart';
import 'product_page.dart';
import 'account_manager.dart';
import 'creationSoiree_page.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    AccountPage.tag: (context) => AccountPage(),
    AppBarScaffold.tag:(context) => AppBarScaffold(),
    ListProduct.tag:(context) => ListProduct(),
    ProductPage.tag:(context)=> ProductPage(),
    AccountManagerPage.tag:(context) => AccountManagerPage(),
    CreationSoireePage.tag:(context) => CreationSoireePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Casa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorBrightness: Brightness.dark,
        primarySwatch: Colors.orange,
        splashColor: Colors.blueGrey,
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}
