import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'home_page.dart';
import 'account_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginData {
  String email = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  _LoginData _data = new _LoginData();
  FocusNode _forgotPasswordFocus;
  FocusNode _mailFocus;
  FocusNode _passwordFocus;
  bool tap = false;
  bool _obscureText = true;
  String testCo;

  Future<http.Response> submit() async {
    if (!this._formKey.currentState.validate()) {
    } else {
      _formKey.currentState.save();
      var url = "https://nevada.dyjix.fr/mobile/connexion";
      var body = jsonEncode(
          {'username': '${_data.email}', 'password': '${_data.password}'});
/*
      http
          .post("http://192.168.8.134:8000/loginMobile",
          headers: {"Content-Type": "application/json"}, body: body)
          .then((http.Response response) {
        json.decode(response.body);
        print(response.body);
      });

      body = jsonEncode({
          'password': 'bbbbbbbbbb'});

      http
          .post("http://192.168.8.134:8000/account/passwordMobile",
          headers: {"Content-Type": "application/json"}, body: body)
          .then((http.Response response) {
        json.decode(response.body);
        print(response.body);
      });
*/
      try {
        return await http
            .post(url,
            headers: {"Content-Type": "application/json"}, body: body)
            .then((http.Response response) {
          print(response.statusCode);
          if (response.statusCode != 200) {
            setState(() {
              testCo = 'Erreur système.';
            });
          } else {
            //json.decode(response.body);
            print(response.body);
            Navigator.of(context).pushNamed(HomePage.tag);
          }
        });
      } catch (e) {
        setState(() {
          testCo = "Erreur réseau, veuillez vous reconnecter.";
        });
      }
    }
    return null;
  }

  void send() {
    if (!_formKey2.currentState.validate()) {
    } else {
      Navigator.of(context).pop();
      Flushbar(
          title: 'Nouveau mot de passe envoyé !',
          message:
          'Vous venez de reçevoir par mail votre nouveau mot de passe, veuillez le modifier au plus vite dans la section de modification.',
          duration: Duration(seconds: 5),
          flushbarPosition: FlushbarPosition.BOTTOM)
          .show(context);
    }
  }

  String _validateEmail(String value) {
    try {
      Validate.notEmpty(value);
    } catch (e) {
      return 'Ce champ est obligatoire.';
    }
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'Email invalide.';
    }
    return null;
  }

  String _validatePassword(String value) {
    try {
      Validate.notEmpty(value);
    } catch (e) {
      return 'Ce champ est obligatoire.';
    }
    return null;
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            content: Container(
              color: Color.fromRGBO(52, 59, 69, 1),
              width: 390.0,
              height: 260.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Expanded(
                    child: Hero(
                      tag: 'logo',
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: SvgPicture.asset(
                          'assets/logocasa.svg',
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Bienvenue Dans la Casa !',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // dialog centre
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Text(
                        "Cette application a été créée dans le cadre d'un projet opposant les deux formations composant la promotion 2018/2019 du Master TNSI de l'université Polytechnique des Hauts-de-France.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                      child: FlatButton(
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        splashColor: Theme.of(context).splashColor,
                        child: Text('Compris !'),
                        onPressed: () {
                          setState(() {
                            tap = false;
                          });
                          Navigator.of(context).pop();
                        },
                      )),
                ],
              ),
            ),
          );
        });
  }

  void _showDialog2() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(0.0),
              content: Container(
                color: Color.fromRGBO(52, 59, 69, 1),
                width: 390.0,
                height: 260.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Expanded(
                      child: Hero(
                        tag: 'logo',
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: SvgPicture.asset('assets/logocasa.svg',
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // dialog centre
                    Expanded(
                      child: Padding(
                          padding:
                          const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Form(
                              key: _formKey2,
                              child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.done,
                                  focusNode: _forgotPasswordFocus,
                                  onFieldSubmitted: (term) {
                                    _forgotPasswordFocus.unfocus();
                                  },
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    fillColor: Color.fromRGBO(62, 71, 80, 1),
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.blueGrey,
                                    ),
                                    labelText: 'Email',
                                    hintText:
                                    'Veuillez saisir votre adresse mail',
                                    helperText: 'Un mail vous sera envoyé.',
                                    hintStyle:
                                    TextStyle(color: Colors.blueGrey),
                                    labelStyle:
                                    TextStyle(color: Colors.blueGrey),
                                    helperStyle:
                                    TextStyle(color: Colors.blueGrey),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: this._validateEmail,
                                  onSaved: (String value) {
                                    this._data.email = value;
                                  }))),
                      flex: 2,
                    ),
                    Expanded(
                        child: FlatButton(
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          splashColor: Theme.of(context).splashColor,
                          child: Text('Envoyer'),
                          onPressed: () {
                            setState(() {
                              tap = false;
                            });
                            this.send();
                          },
                        )),
                  ],
                ),
              ));
        });
  }

  @override
  void initState() {
    super.initState();

    _mailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _forgotPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    _mailFocus.dispose();
    _passwordFocus.dispose();
    _forgotPasswordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: SvgPicture.asset('assets/logocasa.svg',
              color: Theme.of(context).primaryColor),
        ));

    final email = TextFormField(
        initialValue: 'thomashennebert@live.fr',
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        focusNode: _mailFocus,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _mailFocus, _passwordFocus);
        },
        autofocus: false,
        decoration: InputDecoration(
          errorText: testCo,
          fillColor: Color.fromRGBO(62, 71, 80, 1),
          filled: true,
          prefixIcon: Icon(
            Icons.person,
            color: Colors.blueGrey,
          ),
          labelText: 'Email',
          hintText: 'Veuillez saisir votre adresse mail',
          hintStyle: TextStyle(color: Colors.blueGrey),
          labelStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(),
        ),
        validator: this._validateEmail,
        onSaved: (String value) {
          this._data.email = value;
        });

    final password = TextFormField(
        initialValue: 'aaaaaaaaaa',
        textInputAction: TextInputAction.done,
        focusNode: _passwordFocus,
        onFieldSubmitted: (value) {
          _passwordFocus.unfocus();
        },
        autofocus: false,
        obscureText: _obscureText,
        decoration: InputDecoration(
          errorText: testCo,
          fillColor: Color.fromRGBO(62, 71, 80, 1),
          filled: true,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.blueGrey,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              semanticLabel: _obscureText ? 'show password' : 'hide password',
              color: Colors.blueGrey,
            ),
          ),
          labelText: 'Mot de passe',
          hintText: 'Veuillez saisir votre mot de passe',
          hintStyle: TextStyle(color: Colors.blueGrey),
          labelStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(),
        ),
        validator: this._validatePassword,
        onSaved: (String value) {
          this._data.password = value;
        });

    final loginButton = RaisedButton(
        child: Text(
          'Connexion',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          this.submit();
        },
        splashColor: Theme.of(context).splashColor);

    final accountCreation = FlatButton(
        child: Text(
          'Mot de passe perdu ?',
          style: TextStyle(color: Colors.blueGrey),
        ),
        onPressed: () {
          _showDialog2();
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent);

    final creationButton = RaisedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Créer un compte  ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
          ),
          Icon(
            Icons.arrow_forward,
            color: Colors.blueGrey,
          )
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      color: Color.fromRGBO(62, 71, 80, 1),
      onPressed: () {
        Navigator.of(context).pushNamed(AccountPage.tag);
      },
      splashColor: Colors.blueGrey,
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            // action button
            IconButton(
                color: Colors.blueGrey,
                tooltip: "Details sur l'application",
                icon: tap ? new Icon(Icons.info_outline) : new Icon(Icons.info),
                iconSize: 35.0,
                onPressed: () {
                  setState(() {
                    tap = true;
                  });
                  _showDialog();
                }),
          ],
        ),
        backgroundColor: Color.fromRGBO(52, 59, 69, 1),
        body: Center(
          child: Form(
            key: this._formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              children: <Widget>[
                SizedBox(height: 10.0),
                logo,
                SizedBox(height: 40.0),
                email,
                SizedBox(height: 10.0),
                password,
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[accountCreation, loginButton],
                ),
                SizedBox(height: 80.0),
                creationButton,
                SizedBox(height: 10.0)
              ],
            ),
          ),
        ));
  }
}
