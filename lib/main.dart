import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';

//import des pages pour les routes

import 'login_page.dart';
import 'home_page.dart';
import 'account_page.dart';
import 'app_bar.dart';
import 'listproduct_page.dart';
import 'product_page.dart';
import 'account_manager.dart';
import 'creationSoiree_page.dart';
import 'friends_list.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    ListProduct.tag:(context) => ListProduct(),
    AccountPage.tag: (context) => AccountPage(),
    AppBarScaffold.tag:(context) => AppBarScaffold(),
    ProductPage.tag:(context)=> ProductPage(),
    AccountManagerPage.tag:(context) => AccountManagerPage(),
    CreationSoireePage.tag:(context) => CreationSoireePage(),
    FriendsListPage.tag:(context) => FriendsListPage(),
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
      home: MySplashPage(),
      routes: routes,

    );
  }
}


class MySplashPage extends StatefulWidget {
  @override
  _MySplashPageState createState() => new _MySplashPageState();
}

class _MySplashPageState extends State<MySplashPage> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 2,
        navigateAfterSeconds: new LoginPage(),
        title: new Text(
          "L'auberge Espagnol Polytechnique",
          style: new TextStyle(color: Colors.blueGrey, fontSize: 20.0),
        ),
        image: Image.asset(
          'assets/logo-casa.png',
        ),
        backgroundColor: Color.fromRGBO(52, 59, 69, 1),
        styleTextUnderTheLoader: new TextStyle(color: Colors.blueGrey),
        photoSize: 100.0,
        loaderColor: Theme.of(context).primaryColor);
  }
}
