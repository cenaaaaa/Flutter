import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

//GOOGLE API KEY =  AIzaSyCexAj
//
// 9Vx_1jyaj_GRjcabvHutIOx-diCQ
const googleApiKey = "AIzaSyCexAj9Vx_1jyaj_GRjcabvHutIOx-diCQ";

///Formatage d'une liste de produits
/*
class ProductList{
  List<Product> products;

  ProductList({
    this.products
  });

  factory ProductList.fromJson(List<dynamic> parsedJson)
  {
    List<Product> products = new List<Product>();
    products = parsedJson.map((i)=> Product.fromJson(i)).toList();

    return new ProductList(
        products: products
    );
  }

}*/

class Product {
  int id;
  String name;
  String description;
  double price;
  int quantity;

  Product({this.id, this.name, this.description, this.price});

  factory Product.fromJson(Map<String, dynamic> parsedJson)
  {
    return new Product(
        id: parsedJson['id'],
        name: parsedJson['name'],
        description: parsedJson['description'],
        price: parsedJson['price']
    );
  }

}

class CreationSoireePage extends StatefulWidget {
  static String tag = 'creaSoiree-page';

  @override
  _CreationSoireeState createState() => new _CreationSoireeState();
}

class _CreationSoireeState extends State<CreationSoireePage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  int userId = 4;
  var _controller1 = new TextEditingController(
      text: "Nom de la Soiree"); //Controller pour le nom de Soirée
  var _controller2 = new TextEditingController(
      text: "Commentaires"); //Controller pour les comments
  var _controller3 = new TextEditingController(text: "Adresse");
  var _controller4 = new TextEditingController(text: "recherche Produit");

  //Liste de roduits qui sera reçue depuis l'API sous forme de JSON
  List<dynamic> listFromAPI = [];


  static List products = ['produit1', 'produit2'];

  static List invites = ['ami1', 'ami2'];
  Map data = new HashMap();

  void iterateMapEntry(key, value) {
    data[key] = value;
    print('$key: $value'); //string interpolation in action
  }

  /// Fonction récupérant les informations d'un produit pour les retourner permettant
  /// l'ajout à la liste des produits choisis par l'utilisateur.
  Product nouveauProduitToList() {

    int i = 0; //Indice du produit que l'utilisateur aura choisi

// Test d'ajout de produit en dur
    Product p = new Product();
    p.id = 1;
    p.name = "testeur";
    p.quantity = 5;
    listFromAPI.add(p);
    p = listFromAPI[0];

    //Popup affichant les produits de l'API

    //p = listFromAPI[i]; récupération du produit sélectionné

    //Choix de la quantité
    //p.quantity = récupérer quantité souhaitée

    //Renvoyer le produit correspondant à l'indice de l'objet
    // cliqué par l'utilisateur avec sa quantité
    return p;
  }
/*
  String nouvelInvite() {
    return "aa";
  }*/

  /// Liste des produits séléctionnés par l'utilisateur
  List<dynamic> elementList = [];

  List<Widget> _getChildren() {
    List<Widget> children = [];
    for (int i = 0; i < elementList.length; i++) {
      children.add(
        new Text(elementList[i].name + "  x" + elementList[i].quantity.toString()),
      );
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    final listeProduit = ListView(
      shrinkWrap: true,
      children: _getChildren(),
    );

    final nomSoiree = TextFormField(
      controller: _controller1,
      validator: (value) {
        if (value.isEmpty) {
          return 'Entre un nom !';
        }
      },
      decoration: InputDecoration(
        fillColor: Color.fromRGBO(62, 71, 80, 1),
        filled: true,
        prefixIcon: Icon(
          Icons.person,
          color: Colors.blueGrey,
        ),
        labelText: 'Nom de la Soirée',
        hintText: 'Fiesta del Costa del Sol',
        hintStyle: TextStyle(color: Colors.blueGrey),
        labelStyle: TextStyle(color: Colors.blueGrey),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
      ),
    );

    final commentaire = TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      controller: _controller2,
      decoration: InputDecoration(
        fillColor: Color.fromRGBO(62, 71, 80, 1),
        filled: true,
        prefixIcon: Icon(
          Icons.person,
          color: Colors.blueGrey,
        ),
        labelText: 'Commentaire',
        hintText: '...',
        hintStyle: TextStyle(color: Colors.blueGrey),
        labelStyle: TextStyle(color: Colors.blueGrey),
        contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
        border: OutlineInputBorder(),
      ),
    );

    final location = PlacesAutocompleteFormField(
        apiKey: googleApiKey,
        controller: _controller3,
        language: "Fr",
        inputDecoration: InputDecoration(
          fillColor: Color.fromRGBO(62, 71, 80, 1),
          filled: true,
          prefixIcon: Icon(
            Icons.person,
            color: Colors.blueGrey,
          ),
          labelText: 'Adresse',
          hintText: '...',
          hintStyle: TextStyle(color: Colors.blueGrey),
          labelStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(),
        ));

    final nomProduit = TextFormField(
      controller: _controller4,
      decoration: InputDecoration(
        fillColor: Color.fromRGBO(62, 71, 80, 1),
        filled: true,
        prefixIcon: Icon(
          Icons.person,
          color: Colors.blueGrey,
        ),
        labelText: 'Nom de Produit',
        hintText: 'Bière',
        hintStyle: TextStyle(color: Colors.blueGrey),
        labelStyle: TextStyle(color: Colors.blueGrey),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
      ),
    );

    final ajoutProduit = RaisedButton.icon(
      color: Color.fromRGBO(62, 71, 80, 1),
      label: Text(
        "Ajouter un produit",
        style: TextStyle(color: Colors.blueGrey),
      ),
      onPressed: () {
        elementList.add(nouveauProduitToList());
        setState(() {});
      },
      icon: Icon(Icons.add),
    );

    final ajoutInvite = RaisedButton.icon(
      color: Color.fromRGBO(62, 71, 80, 1),
      label: Text(
        "Ajouter un invité",
        style: TextStyle(color: Colors.blueGrey),
      ),
      onPressed: () {
        //invites.add(nouvelInvite());
        setState(() {});
      },
      icon: Icon(Icons.add),
    );

    /*final listeProduit = ListView.builder(
        shrinkWrap: true,
        primary: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Container(
            child: Text(
              products[index],
              style: TextStyle(color: Colors.blueGrey),
            ),
            decoration: BoxDecoration(),
          );
        });*/

    /*final listeAmi = ListView.builder(
        shrinkWrap: true,
        itemCount: invites.length,
        itemBuilder: (context, index) {
          return Container(
            child: Text(
              invites[index],
              style: TextStyle(color: Colors.blueGrey),
            ),
            decoration: BoxDecoration(),
          );
        });*/

    Future _selectDate() async {
      DateTime picked = await showDatePicker(
          context: context,
          initialDate: new DateTime.now(),
          firstDate: new DateTime(2018),
          lastDate: new DateTime(2020));
      if (picked != null) setState(() => _date = picked);
    }

    Future _selectTime() async {
      TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: new TimeOfDay.fromDateTime(DateTime.now()),
      );
      if (picked != null) setState(() => _time = picked);
    }

    final timeButton = new RaisedButton.icon(
      color: Color.fromRGBO(62, 71, 80, 1),
      label: Text(
        "Heure : " + _time.hour.toString() + ":" + _time.minute.toString(),
        style: TextStyle(color: Colors.blueGrey),
      ),
      onPressed: _selectTime,
      icon: Icon(Icons.access_time),
    );

    final dateButton = new RaisedButton.icon(
      color: Color.fromRGBO(62, 71, 80, 1),
      label: Text(
        "Date: " + _date.day.toString() + "/" + _date.month.toString(),
        style: TextStyle(color: Colors.blueGrey),
      ),
      onPressed: _selectDate,
      icon: Icon(Icons.calendar_today),
    );

    final formulaire = Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 36.0),
          nomSoiree,
          SizedBox(height: 8.0),
          commentaire,
          SizedBox(height: 16.0),
          location,
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              dateButton,
              SizedBox(width: 25),
              timeButton,
            ],
          ),
          // nomProduit,
          Expanded(
            child: listeProduit,
          ),
          ajoutProduit,
          /*Expanded(
            child: listeAmi,
          ),*/
          ajoutInvite,
          RaisedButton(
              color: Colors.orange,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  String heure = _time.hour.toString();
                  String minute = _time.minute.toString();
                  if (_time.hour < 10) {
                    heure = "0" + _time.hour.toString();
                  }
                  if (_time.minute < 10) {
                    minute = "0" + _time.minute.toString();
                  }
                  data["organisateur_id"] = userId;
                  data["title"] = _controller1.text;
                  data["description"] = _controller2.text;
                  data["address"] = "";
                  data["date"] = _date.year.toString() +
                      "-" +
                      _date.month.toString() +
                      "-" +
                      _date.day.toString() +
                      " " +
                      heure +
                      ":" +
                      minute +
                      ":00";
                  data["products"] = products;
                  data["invites"] = invites;
                  data["adresse"] = _controller3.text;
                  data.forEach(iterateMapEntry);
                }
              },
              child: Text(
                'Valider',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      color: Color.fromRGBO(62, 71, 80, 1),
      child: formulaire,
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Nouvelle Soirée",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.orange,
      ),
      body: body,
    );
  }
}

class MyExpansionTile extends StatefulWidget {
  final String did;
  final String name;

  MyExpansionTile(this.did, this.name);

  @override
  State createState() => new MyExpansionTileState();
}

class MyExpansionTileState extends State<MyExpansionTile> {
  PageStorageKey _key;
  int value = 0;
  bool valueCheck = false;

  void _value1Changed(bool value) => setState(() => valueCheck = value);

  @override
  Widget build(BuildContext context) {
    _key = new PageStorageKey('${widget.did}');
    return new ExpansionTile(
      key: _key,
      title: new Text(widget.did),
      children: <Widget>[
        new GestureDetector(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
            child: ListTile(
              dense: true,
              title: new Text(widget.name),
            ),
          ),
          onTap: () {
            return showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(0.0),
                    content: Container(
                      color: Color.fromRGBO(62, 71, 80, 1),
                      width: 200.0,
                      height: 130.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 2.0, right: 2.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Produit 1",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Qte : " + '$value',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13.0,
                                          ),
                                        ),
                                        RaisedButton.icon(
                                          color: Color.fromRGBO(62, 71, 80, 1),
                                          label: Text(
                                            "",
                                            style: TextStyle(
                                                color: Colors.blueGrey),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              value = value + 1;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.add,
                                          ),
                                        ),
                                        RaisedButton.icon(
                                          color: Color.fromRGBO(62, 71, 80, 1),
                                          label: Text(
                                            "",
                                            style: TextStyle(
                                                color: Colors.blueGrey),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (value > 0) {
                                                value = value + -1;
                                              }
                                            });
                                          },
                                          icon: Icon(Icons.remove),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            flex: 2,
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                              child: FlatButton(
                                textColor: Colors.white,
                                color: Theme.of(context).primaryColor,
                                splashColor: Colors.orangeAccent,
                                child: Text('Valider'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ],
    );
  }
}
