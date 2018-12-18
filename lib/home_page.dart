import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'listproduct_page.dart';
import 'creationSoiree_page.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  static final HomeKey = new GlobalKey<_HomePageState>();

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool tap = false;
  bool divide = false;
  final int nombreFetePerLigne = 2;
  int _idUser = 2;
  int get idUser => _idUser;
  static List soireeOrgUser = [1, 1, 2, 2, 5, 4, 3, 1, 8];
  int longueur = soireeOrgUser.length;

  List tri() {
    for (int i = 0; i < longueur; i++)
      if (soireeOrgUser[i] == _idUser) {
        soireeOrgUser[i] = 0;
      }
    soireeOrgUser.sort();
    for (int i = 0; i < longueur; i++) {
      if (soireeOrgUser[i] == 0) soireeOrgUser[i] = _idUser;
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
        fontSize: 24,
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
                      child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: Colors.black87,
                          title: Text("Créer une soirée" ,textAlign: TextAlign.center),
                        ) ,
                        child: Image.network('https://t4.ftcdn.net/jpg/00/18/10/11/500_F_18101190_MPwhgdRKNRFmoOluwzxn7epEB0496pGJ.jpg'),
                      )

                      /*Column(children: [
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
                      ]),*/
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
                Navigator.of(context).pushNamed(CreationSoireePage.tag);

              },
            );
          }
          return new GestureDetector(
              child: Container(
                child: Card(
                    color: Colors.blueGrey,
                    child: GridTile(
                      footer: GridTileBar(
                        backgroundColor: Colors.black87,
                        title: Text("Méga teuf" ,textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
                      ) ,
                      child: Image.network('http://earlycoke.com/images/martin_metalsigns_81.jpg?crc=4247472040'),
                    )

                  /*Container(
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
                      ]
                      ),
                    )*/
                ),
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, bottom: 15.0, top: 15.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10.0,
                        spreadRadius: -15.0)
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
      color: Color.fromRGBO(52, 59, 69, 1),
      child: Column(children: <Widget>[
        soireeOrganise,
        SizedBox(height: 20.0),
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
