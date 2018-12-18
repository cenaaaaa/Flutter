import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AccountManager extends UserAccountsDrawerHeader {
  AccountManager(String username,
      String email,
      { String accountPicture }) : super(
      accountName: Text(username),
      accountEmail: Text(email),
      currentAccountPicture: CircleAvatar(
          child: FlutterLogo(size: 42.0),
          backgroundColor: Colors.grey
      )
  );
}

class AccountManagerPage extends StatefulWidget {
  static String tag ='account-page-manager';
  @override
  _AccountManagerPageState createState() => _AccountManagerPageState();
}

class _AccountManagerPageState extends State<AccountManagerPage> {
  final _formKey = GlobalKey<FormState>();
  String _actualPassword = "bite";
  String _newPassword;
  Widget avatar = IconTheme(data: IconThemeData(), child: FlutterLogo(size: 48.0));

  String _isValidPassword(String inputPassword, String toCompare, String errorMessage)
  => inputPassword != toCompare ? errorMessage : null;

  void _onPressed() {
    this._formKey.currentState.validate();
  }

  void _changeImage() async {
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      avatar = Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: FileImage(file), fit: BoxFit.fill)
          )
      );
    });
    /*
    showDialog<String>(
      context: context,
      builder: (BuildContext context)=> SimpleDialog(
        title: const Text('Mes Avatars'),
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Text('First Avatar'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Text('Second Avatar'),
            onTap: () => Navigator.pop(context, 'Second Avatar'),
          ),
          ListTile(
            leading: Icon(Icons.add_a_photo),
            title: Text('Add Avatar'),
            onTap: () => Navigator.pop(context, 'Add Avatar'),
          ),
        ],
      ),
    ).then<String>((returnVal) {
      if (returnVal == null) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('You Clicked: $returnVal'),
            action: SnackBarAction(
                label: 'OK', onPressed: () {}),
          ),
        );
      }
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    var actualPasswordField = TextFormField(
        textCapitalization: TextCapitalization.none,
        obscureText: true,
        decoration: InputDecoration(
          fillColor: Color.fromRGBO(62, 71, 80, 1),
          filled: true,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.blueGrey,
          ),
          labelText: 'Mot de passe actuel',
          hintStyle: TextStyle(color: Colors.blueGrey),
          labelStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(),
        ),
        validator: (String value) => _isValidPassword(
            value,
            _actualPassword,
            "Mot de passe incorrect"
        )
    );

    var firstPasswordField = TextFormField(
      textCapitalization: TextCapitalization.none,
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Color.fromRGBO(62, 71, 80, 1),
        filled: true,
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.blueGrey,
        ),
        labelText: 'Nouveau mot de passe',
        hintStyle: TextStyle(color: Colors.blueGrey),
        labelStyle: TextStyle(color: Colors.blueGrey),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
      ),
      validator: (String value) { _newPassword = value; return null; },
    );

    var secondPasswordField = TextFormField(
        textCapitalization: TextCapitalization.none,
        obscureText: true,
        decoration: InputDecoration(
          fillColor: Color.fromRGBO(62, 71, 80, 1),
          filled: true,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.blueGrey,
          ),
          labelText: 'Confirmer mot de passe',
          hintStyle: TextStyle(color: Colors.blueGrey),
          labelStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(),
        ),
        validator: (String value) => _isValidPassword(
            value,
            _newPassword,
            "Mot de passe de confirmation incorrect"
        )
    );

    var emailField = TextFormField(
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          fillColor: Color.fromRGBO(62, 71, 80, 1),
          filled: true,
          prefixIcon: Icon(
            Icons.mail,
            color: Colors.blueGrey,
          ),
          labelText: 'Adresse mail',
          hintStyle: TextStyle(color: Colors.blueGrey),
          labelStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(),
        )
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Mon compte"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        backgroundColor: Color.fromRGBO(52, 59, 69, 1),
        body: Form(
            key: _formKey,
            child: Center(
                child: ListView(
                  padding: EdgeInsets.only(left: 24.0, right: 24.0),
                  children: <Widget>[
                    /*SizedBox(height: 24),
                Center(
                  child: Text(
                      "Someone",
                      style: TextStyle(
                          fontSize: 20.0
                      )
                  ),
                ),*/
                    SizedBox(height: 20),
                    CircleAvatar(
                      child: avatar,
                      backgroundColor: Colors.transparent,
                      radius: 48.0,
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                        child: Center(
                            child: Text(
                                "Changer mon avatar",
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.none
                                )
                            )
                        ),
                        onTap:(){
                          _changeImage();
                        }
                    ),
                    SizedBox(height: 24),
                    actualPasswordField,
                    SizedBox(height: 20),
                    firstPasswordField,
                    SizedBox(height: 20),
                    secondPasswordField,
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 24),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                            child: Text("Annuler",
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.blueGrey)
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            onPressed: () => Navigator.of(context).pop(),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent
                        ),
                        RaisedButton(
                          child: Text("Valider", style: TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          onPressed: _onPressed,
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    )
                  ],
                )
            )
        )
    );
  }
}

class AccountManagerPageRoute extends MaterialPageRoute<AccountManagerPage> {
  AccountManagerPageRoute() : super(builder: (BuildContext context) {
    return AccountManagerPage();
  });
}

