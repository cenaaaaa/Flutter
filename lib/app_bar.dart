import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'account_manager.dart';
import 'friends_list.dart';

class AppBarScaffold extends StatelessWidget {

  static String tag = 'app-bar';
  final Widget body;
  final String title;
  final Widget bottom;

  AppBarScaffold({this.body, this.title,this.bottom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      backgroundColor: Color.fromRGBO(52, 59, 69, 1),
      appBar: AppBar(
        title: Text('$title', textAlign: TextAlign.center),
        backgroundColor: Color.fromRGBO(243, 146, 26, 1),
        bottom: bottom,
      ),
      drawer: Drawer(
        child:Container(
          color:Color.fromRGBO(52, 59, 69, 1),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: <Widget>[
              DrawerHeader(
                child: Hero(
                    tag: 'logo',
                    child: SvgPicture.asset(
                      'assets/logocasa.svg',
                      color: Color.fromRGBO(243, 146, 26, 1),
                    )
                ),
              ),
              Text("User Name",style:TextStyle(color: Colors.blueGrey, fontSize: 24)),
              Divider(
                color: Color.fromRGBO(243, 146, 26, 1),
              ),
              Expanded(
                child: Align(
                  child: GestureDetector(
                      child: Text('Accueil', style:TextStyle(color: Colors.blueGrey, fontSize: 36)),
                      onTap:()
                      {
                        Navigator.of(context).pushNamed(HomePage.tag);
                      }
                  ),
                ),
              ),
              Divider(
                color: Color.fromRGBO(243, 146, 26, 1),
              ),
              Expanded(
                child: Align(
                  child: GestureDetector(
                      child: Text('Mon compte',style:TextStyle(color: Colors.blueGrey, fontSize: 36)),
                      onTap:()
                      {
                        Navigator.of(context).pushNamed(AccountManagerPage.tag);
                      }
                  ),
                ),
              ),
              Divider(
                color: Color.fromRGBO(243, 146, 26, 1),
              ),
              Expanded(
                child: Align(
                  child: GestureDetector(
                      child: Text('Ami(e)s', style:TextStyle(color: Colors.blueGrey, fontSize: 36)),
                      onTap:()
                      {
                        Navigator.of(context).pushNamed(FriendsListPage.tag);
                      }
                  ),
                ),
              ),
              Divider(
                color: Color.fromRGBO(243, 146, 26, 1),
              ),
              Expanded(
                child: Align(
                  child: GestureDetector(
                      child: Text('Déconnexion',style:TextStyle(color: Colors.blueGrey, fontSize: 36)),
                      onTap:()
                      {
                        Navigator.of(context).pushNamed(LoginPage.tag);
                      }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
