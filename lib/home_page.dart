import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'listproduct_page.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool tap = false;
  bool divide = false;
  final int nombreFetePerLigne = 2;
  int idUser = 2;
  static List soireeOrgUser = [1, 1, 2, 2, 5, 4, 3, 1, 8];
  int longueur = soireeOrgUser.length;

  List tri() {
    for (int i = 0; i < longueur; i++)
      if (soireeOrgUser[i] == idUser) {
        soireeOrgUser[i] = 0;
      }
    soireeOrgUser.sort();
    for (int i = 0; i < longueur; i++) {
      if (soireeOrgUser[i] == 0) soireeOrgUser[i] = idUser;
    }
    return soireeOrgUser;
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text("Accueil",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 35,
          )),
      backgroundColor: Colors.orange,
    );

    final soireeOrganise = Text(
      "Fêtes Organisées :",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 20,
        color: Colors.blueGrey,
      ),
    );

    final feteOrgan = Container(
      child: GridView.builder(
        shrinkWrap: true,
        primary: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: nombreFetePerLigne),
        itemCount: longueur + 1,
        itemBuilder: (context, index) {
          soireeOrgUser = tri();
          if (index == longueur) {
            return new GestureDetector(
              child: Container(
                child: Card(
                    color: Colors.blueGrey,
                    child: Container(
                      child: Column(children: [
                        Expanded(
                          child: Image.network(
                            'https://t4.ftcdn.net/jpg/00/18/10/11/500_F_18101190_MPwhgdRKNRFmoOluwzxn7epEB0496pGJ.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          "Creer Nouveau Event",
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                    )),
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, bottom: 15.0, top: 15.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10.0,
                        spreadRadius: -5.0)
                  ],
                ),
              ),
              onTap: () {

                ///ouvrir la page de creation d'un nouvelle evenement
                //Navigator.of(context).pushNamed(ListProduct.tag);

              },
            );
          }
          return new GestureDetector(
              child: Container(
                child: Card(
                    color: Colors.blueGrey,
                    child: Container(
                      child: Column(children: [
                        Expanded(
                          child: Image.network(
                            'https://image.freepik.com/icones-gratuites/menu-bouton-circulaire_318-67927.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          "Event name (user " +
                              soireeOrgUser[index].toString() +
                              ")",
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                    )),
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, bottom: 15.0, top: 15.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10.0,
                        spreadRadius: -5.0)
                  ],
                ),
              ),
              onTap: () {
                /// Aller sur la page des produits de l'evenement
                Navigator.of(context).pushNamed(ListProduct.tag);
              }
          );
        },
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      color: Color.fromRGBO(62, 71, 80, 1),
      child: Column(children: <Widget>[
        soireeOrganise,
        Expanded(
          child: feteOrgan,
        ),
      ]),
    );

    return AppBarScaffold(
      body: body,
      title: "Home Page" ,
    );
  }
}
