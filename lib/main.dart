import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'account_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    AccountPage.tag: (context) => AccountPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Casa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorBrightness: Brightness.dark,
        primarySwatch: Colors.orange,
        splashColor: Colors.orangeAccent,
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}
