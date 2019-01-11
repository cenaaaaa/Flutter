import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'listproduct_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String _ProductName(int id) {
  return 'Coca-cola';
}

double _ProductPrice(int id){
  return 8.75;
}

String _ProductDescription(int id){
  return 'Eau gazéifiée ; sucre ; colorant : caramel (E 150d) ; acidifiant : aci, de phosphorique ; extraits végétaux ; arôme caféine ; caféine 10 mg';
}

class ProductPage extends StatefulWidget {
  static String tag = 'product-page';

  @override
  _ProductPageState createState() => new _ProductPageState();
}


class _ProductPageState extends State<ProductPage> {
  static int id;
  String name = _ProductName(id);
  double price = _ProductPrice(id);
  String description = _ProductDescription(id);

  String barcode = "";
  int nbProduit=0;
  int nbProduitRestant =15;

  //Nécessaire pour utiliser l'API google Map
  GoogleMapController mapController;

  Container _BarCodeEmpty(){
      return new Container(
        padding: EdgeInsets.all(5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: RaisedButton(
                  child: Text(
                    'Retour',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.pop(context),
                  splashColor: Theme.of(context).splashColor,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: RaisedButton(
                  child: Text(
                    'Valider',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Confirmation'),
                          content: Text(
                              'Vous souhaitez apporter ${nbProduit} ${name} à la soirée.'
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Annuler'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            FlatButton(
                              child: Text('Ok'),

                              onPressed: () => Navigator.of(context).pushNamed(ListProduct.tag), ///retour liste produits
                            )
                          ],
                        )
                    );
                  },
                  splashColor: Theme.of(context).splashColor,
                ),
              ),
            ]
        ),
        color: Color.fromRGBO(52, 59, 69, 1),
      );
  }

  @override
  initState() {
    super.initState();
  }

  File galleryFile;

  imageSelectorGallery() async {
    galleryFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
// maxHeight: 50.0,
// maxWidth: 50.0,
    );
    print("Vous avez selectionner la gallerie d'image : " + galleryFile.path);
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() { mapController = controller; });
  }

  final ImageCircle = new Container(
    height: 200.0,
    width: 200.0,
    margin: new EdgeInsets.symmetric(
        vertical: 12.5
    ),
    alignment: FractionalOffset.centerLeft,
    decoration: BoxDecoration(
        boxShadow: [
          new BoxShadow(
              color: Colors.black54,
              blurRadius:2,
              spreadRadius: 1.0)
        ],
        shape: BoxShape.circle,
        image: new DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage('http://earlycoke.com/images/martin_metalsigns_81.jpg?crc=4247472040')
        )
    ),
  );

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: Text('Description Produit'),
      ),
      backgroundColor: Color.fromRGBO(52, 59, 69, 1),
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ImageCircle,
                      Expanded(
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text(
                                  '${name}',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Prix: ${price}€',
                                  style: TextStyle(color: Colors.blueGrey),
                                ),

                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Nombre: ${nbProduit}/${nbProduitRestant}',
                                      style: TextStyle(
                                          color: Colors.blueGrey
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        nbProduit<nbProduitRestant? IconButton(
                                            icon: Icon(Icons.add_circle),
                                            color: Colors.green,
                                            onPressed: () => setState(() => nbProduit ++)
                                        ): new Container(child: Text('\n\n'),),
                                        nbProduit!=0? IconButton(
                                          icon: Icon(Icons.do_not_disturb_on),
                                          color: Colors.red,
                                          onPressed: () => setState(() => nbProduit --),
                                        ):new Container(child: Text('\n\n'),)
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    children: [
                      Text(
                        'Description du produit: \n\n',
                        textAlign: TextAlign.justify,
                        style: TextStyle(decoration: TextDecoration.underline,color: Colors.blueGrey, fontSize: 18.0),
                      ),
                      Text(
                        '${description}\n\n',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      Text(
                        '${barcode}',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
                Container(
                  child:Column(
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          width:300,
                          height: 200,
                          child: GoogleMap(
                              onMapCreated: _onMapCreated),
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  child: const Text('Trouver le magasin le plus proche'),
                  onPressed: mapController == null ? null : () {
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                      const CameraPosition(
                        bearing: 270.0,
                        target: LatLng(51.5160895, -0.1294527),
                        tilt: 30.0,
                        zoom: 17.0,
                      ),
                    ));
                  },
                ),
                _BarCodeEmpty()
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget displayImage()
  {
    return new SizedBox(
      height: 300.0,
      width: 400.0,
      child: galleryFile == null
          ? new Text('Rien à afficher')
          : new Image.file(galleryFile),
    );
  }

}
