import 'package:flutter/material.dart';
import 'product_page.dart';
import 'home_page.dart';


class ListProduct extends StatefulWidget {
  static String tag ='List-Product';
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {


  static int numberCount=10;

  //A changer par la suite quand on aura les propriétés intrinsèques à chaque produit
  static double quantite=0.0;
  static double quantiteMax=15.0;
  static double ratio = quantite/quantiteMax;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          /// Créer un Inkwell qui retourne vers la page de list event
          leading: InkWell(
            child: Icon(Icons.keyboard_return),
            onTap: () => Navigator.of(context).pushNamed(HomePage.tag),
          ),
          title: new Text('La mega teuf'),
          actions: <Widget>[
            Theme(
                data: ThemeData(
                    dialogBackgroundColor: Color.fromRGBO(52, 59, 69, 1)),
                child: buildShowDialog()
            )
          ],
        ),
        body: new Container(
          //height: 500.0,
          color: Color.fromRGBO(52, 59, 69, 1),
          padding: EdgeInsets.all(8.0),
          child: new ListView.builder(
              itemCount: numberCount,
              itemBuilder:(BuildContext context , int i){
                if(i == numberCount-1){
                  return ListTile(
                    title: Icon(Icons.add),
                    onTap: () {},
                  );
                }
                return Column(
                  children: <Widget>[
                    _buidRow(context,i)
                  ],
                );
              }
          ),
        ),

        bottomNavigationBar:new Container(
            color: Colors.orange,
            height: 55.0,
            child: new IconButton(
              iconSize: 32.0,
              color: Colors.white,
              icon:Icon(Icons.add),
              tooltip: 'Add a product',
              onPressed:null ,
            )

        )

    );
  }

  final ImageCircle = new Container(
    height: 75.0,
    width: 75.0,
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

  static Color progressBarColor(double ratio)
  {
    if(ratio <= 0.33)
      return Colors.red;
    else if(ratio <= 0.66)
      return Colors.orange;
    else if(ratio < 1)
      return Colors.yellow;
    else
      return Colors.green;
  }

  final planetCard = new Container(

    height: 100.0,
    margin: new EdgeInsets.only(left: 46.0),
    decoration: new BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black54,
          blurRadius: 8.0,
          spreadRadius: 5.0,
          //  offset: new Offset(0.0, 10.0),
        ),
      ],
    ),

    child: Container(
      margin: new EdgeInsets.fromLTRB(50.0, 16.0, 16.0, 16.0),

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('Produit',style: TextStyle(fontSize: 15.0) ),
            new Container(height: 5.0),
            /*
                new Container(
                    margin: new EdgeInsets.symmetric(vertical: 8.0),
                    height: 2.0, width: 108.0,
                    color: new Color.fromRGBO(52, 59, 69, 1)
                ),*/

            new LinearProgressIndicator(
              value: ratio,
              valueColor: AlwaysStoppedAnimation<Color>(progressBarColor(ratio)),
            ),
            new Container(height: 5.0),
            new Row(
              children: <Widget>[
                new Text('Quantité restante',style: TextStyle(fontSize: 15.0)),
                new Container(width: 24.0),
                new Text("15/15",style: TextStyle(fontSize: 15.0)),
              ],
            ),
          ]
      ),
    ),
  );

  final buttonCard = new Container(
    child: new Container(
      alignment: FractionalOffset.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          //TEST
          quantiteMax == 15 ? IconButton(
            icon: new Icon(Icons.add_comment),
            onPressed: (){},
          ): new Container(
          ),
        ],
      ),
    ),
  );


  Widget _buidRow( BuildContext context ,int idx){
    return InkWell(
      child: Container(
          margin: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0
          ),
          child: new Stack(
            children: <Widget>[
              planetCard,
              ImageCircle,
              buttonCard
            ],
          )
      ),
      onTap: () => Navigator.of(context).pushNamed(ProductPage.tag),

    );

  }

}

class buildShowDialog extends StatefulWidget {
  @override
  _buildShowDialogState createState() => _buildShowDialogState();
}

class _buildShowDialogState extends State<buildShowDialog> {
  bool tap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon:Icon(Icons.local_play),
        iconSize: 35.0,
        color: Colors.white,
        onPressed: (){
          setState(() {
            tap = true;
          });

          showDialog<String>(
            context: context,
            barrierDismissible: false,
            //barrierColor: Colors.black54,
            //barrierColor: Color.fromRGBO(52, 59, 69, 1),

            builder: (BuildContext context)=> SimpleDialog(
              //title: const Text('Information sur la Soiree'),

              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(0),
                  child:Image.network(
                    'https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg',
                    height: 250,
                    width: 250,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today,color: Colors.blueGrey,),
                  title: Text('Le : 13/12/2018',
                      style:TextStyle(fontSize: 16.0, color: Colors.blueGrey,)
                  ),
                  trailing: Text('à : 20H00',
                      style:TextStyle(fontSize: 16.0, color: Colors.blueGrey,)
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.location_on,color: Colors.blueGrey,),
                  title: Text('23 rue genial, 59300 Valenciennes',
                      style:TextStyle(fontSize: 16.0, color: Colors.blueGrey,)),
                ),
                ListTile(
                  leading: Icon(Icons.announcement,color: Colors.blueGrey,),
                  title: Text('Oublier pas de ramener ce qui faut pour bien profiter de la soiree',
                      style:TextStyle(fontSize: 16.0, color: Colors.blueGrey,)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("OK", style: Theme.of(context).textTheme.button), // style pour ne pas qu'il soit transparent
                      color: Colors.orange, // couleur du bouton
                      onPressed: () => Navigator.pop(context), // Retourner a la page precedente
                    )
                  ],
                )

              ],
            ),
          );

        }
      //child: Text("Show dialog"),
    );

  }
}

