import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'listproduct_page.dart';
import 'creationSoiree_page.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Party.dart';

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
  static List soireeOrgUser = [1, 2, 3, 4, 5, 6]; //id de la soiree organisé par l'user
  int longueurOrg = soireeOrgUser.length;
  static List soireePartUser = [1, 2, 3, 4, 5, 6, 7, 8, 9]; //id de la soiree participante de l'user
  int longueurPart = soireePartUser.length;

  List<Party> party;

  Future<Party> getData() async {
    /// Insertion de l'URL contenant le json avec les informations à récupérer
    final response = await http.get('https://raw.githubusercontent.com/ZygoMatic74/Fake-Json/master/party/parties/1/parties.json',
        headers: {
          "Accept": "application/json"
        });

    this.setState((){
      party= emptyFromJson(response.body);
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }



  @override
  Widget build(BuildContext context) {

    final soireeOrganise = Text(
      "Fêtes Organisées :",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 24,
        color: Colors.blueGrey,
      ),
    );


    final feteOrgan = GridView.count(
      crossAxisCount: nombreFetePerLigne,
      scrollDirection: Axis.vertical,
      children: List.generate((party.length+1), (index) {
        if (index==party.length){
          return Center(
              child: GestureDetector(
                  child:Container(
                    child: Card(
                      color: Colors.blueGrey,
                      child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: Colors.black87,
                          title: Text("Créer une soirée" ,textAlign: TextAlign.center),
                        ) ,
                        child: Image.network('https://t4.ftcdn.net/jpg/00/18/10/11/500_F_18101190_MPwhgdRKNRFmoOluwzxn7epEB0496pGJ.jpg'),
                      ),
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
                    ///ouvrir la page de creation d'un nouvelle evenement
                    Navigator.of(context).pushNamed(CreationSoireePage.tag);
                  }
              )
          );
        }else {
          return Center(
              child: GestureDetector(
                  child: Container(
                    child: Card(
                      color: Colors.blueGrey,
                      child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: Colors.black87,
                          ///Titre de la soirée
                          title: Text(party[index].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15)),
                        ),
                        child: Image.network(
                          ///Image de la soirée
                            party[index].image),
                      ),
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
              )
          );
        }
      }),
    );

    final bodyOrg = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      color: Color.fromRGBO(62, 71, 80, 1),
      child: Column(children: <Widget>[
        soireeOrganise,
        SizedBox(height: 20.0),
        Expanded(
          child: feteOrgan,
        ),
      ]),
    );

    final soireePart = Text(
      "Fêtes Participant :",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 24,
        color: Colors.blueGrey,
      ),
    );

    final fetePart = GridView.count(
      crossAxisCount: nombreFetePerLigne,
      scrollDirection: Axis.vertical,
      children: List.generate(longueurPart, (index) {
        return Center(
            child: GestureDetector(
                child: Container(
                  child: Card(
                    color: Colors.blueGrey,
                    child: GridTile(
                      footer: GridTileBar(
                        backgroundColor: Colors.black87,
                        title: Text("Méga teuf ${soireePartUser[index]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15)),
                      ),
                      child: Image.network(
                          'http://earlycoke.com/images/martin_metalsigns_81.jpg?crc=4247472040'),
                    ),
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
            )
        );
      }),
    );

    final bodyPart = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      color: Color.fromRGBO(62, 71, 80, 1),
      child: Column(children: <Widget>[
        soireePart,
        SizedBox(height: 20.0),
        Expanded(
          child: fetePart,
        ),
      ]),
    );

    final _TabPages = <Widget>[
      Center(
        child: bodyOrg,
      ),
      Center(
        child: bodyPart,
      )
    ];

    final _Tabs = <Tab>[
      Tab(
          text: 'Organigateur'
      ),
      Tab(
          text: 'Participant'
      )
    ];

    return DefaultTabController(
        length: _Tabs.length,
        child: AppBarScaffold(
          body: TabBarView(
            children: _TabPages,
          ),
          title: "Home Page" ,
          bottom: TabBar(tabs: _Tabs,),
        )
    );
  }
}


List<Party> emptyFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Party>.from(jsonData.map((x) => Party.fromJson(x)));
}