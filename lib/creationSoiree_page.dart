import 'package:flutter/material.dart';

class CreationSoireePage extends StatefulWidget {
  static String tag = 'creaSoiree-page';

  @override
  _CreationSoireeState createState() => new _CreationSoireeState();
}

class _CreationSoireeState extends State<CreationSoireePage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  var _controller1 = new TextEditingController();
  var _controller2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      controller: _controller2,
      validator: (value) {},
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
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
      ),
    );

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
          context: context, initialTime: new TimeOfDay.now());
      if (picked != null) setState(() => _time = picked);
    }

    final formulaire = Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 48.0),
          nomSoiree,
          SizedBox(height: 8.0),
          commentaire,
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton.icon(
                color: Color.fromRGBO(62, 71, 80, 1),
                label: Text(
                  "Date : " +
                      _date.day.toString() +
                      "/" +
                      _date.month.toString(),
                  style: TextStyle(color: Colors.blueGrey),
                ),
                onPressed: _selectDate,
                icon: Icon(Icons.calendar_today),
              ),
              new RaisedButton.icon(
                color: Color.fromRGBO(62, 71, 80, 1),
                label: Text(
                  "Heure Début : " +
                      _time.hour.toString() +
                      ":" +
                      _time.minute.toString(),
                  style: TextStyle(color: Colors.blueGrey),
                ),
                onPressed: _selectTime,
                icon: Icon(Icons.access_time),
              ),
            ],
          ),
          RaisedButton(
            color: Colors.orange,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                print(
                    "Soirée: " + _controller1.text + " Commentaires: "+ _controller2.text);
              }
            },
            child: Text(
              'Valider',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      color: Color.fromRGBO(62, 71, 80, 1),
      child: Column(children: <Widget>[
        formulaire,
      ]),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Nouvelle Soirée",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
            )),
        backgroundColor: Colors.orange,
      ),
      body: body,
    );
  }
}
