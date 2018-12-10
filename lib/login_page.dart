import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'home_page.dart';
import 'account_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  _LoginData _data = new _LoginData();
  FocusNode _mailFocus;
  FocusNode _passwordFocus;
  bool tap = false;
  bool _obscureText = true;

  String _validateEmail(String value) {
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'Email invalide.';
    }
    return null;
  }

  String _validatePassword(String input) {
    try {
      Validate.isPassword(input);
    } catch (e) {
      return 'Mot de passe invalide.';
    }
    return null;
  }

  void submit() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');

      Navigator.of(context).pushNamed(HomePage.tag);
    }
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            content: Container(
              color: Color.fromRGBO(62, 71, 80, 1),
              width: 290.0,
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
                          color: Color.fromRGBO(243, 146, 26, 1),
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
                    splashColor: Colors.orangeAccent,
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

  @override
  void initState() {
    super.initState();

    _mailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _mailFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: SvgPicture.asset(
          'assets/logocasa.svg',
          color: Color.fromRGBO(243, 146, 26, 1),
        ),
      ),
    );

    final email = TextFormField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        focusNode: _mailFocus,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _mailFocus, _passwordFocus);
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
        textInputAction: TextInputAction.done,
        focusNode: _passwordFocus,
        onFieldSubmitted: (value) {
          _passwordFocus.unfocus();
        },
        autofocus: false,
        obscureText: _obscureText,
        decoration: InputDecoration(
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
      splashColor: Colors.orangeAccent,
    );

    final accountCreation = FlatButton(
        child: Text(
          'Mot de passe perdu ?',
          style: TextStyle(color: Colors.blueGrey),
        ),
        onPressed: () {},
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
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            // action button
            new IconButton(
                color: Colors.blueGrey,
                splashColor: Colors.blueGrey,
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
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                SizedBox(height: 48.0),
                email,
                SizedBox(height: 8.0),
                password,
                SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[accountCreation, loginButton],
                ),
                SizedBox(height: 64.0),
                creationButton
              ],
            ),
          ),
        ));
  }
}
