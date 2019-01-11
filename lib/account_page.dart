import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'login_page.dart';

class AccountPage extends StatefulWidget {
  static String tag = 'account-page';

  @override
  _AccountPageState createState() => new _AccountPageState();
}

class _AccountData {
  String name = '';
  String phoneNumber = '';
  String email = '';
  String password = '';
}

class _AccountPageState extends State<AccountPage> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();
  final _formKey = GlobalKey<FormState>();
  _AccountData _data = new _AccountData();
  FocusNode _nameFocus;
  FocusNode _phoneNumberFocus;
  FocusNode _mailFocus;
  FocusNode _passwordFocus;
  FocusNode _confirmPasswordFocus;
  bool tap = false;
  bool _obscureText = true;
  bool _obscureText2 = true;

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

  String _confirmPassword(String input) {
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    try {
      Validate.isPassword(input);
    } catch (e) {
      return 'Mot de passe invalide.';
    }
    if (passwordField.value != input) return 'The passwords don\'t match';
    return null;
  }

  String _confirmData(String input) {
    try {
      Validate.notEmpty(input);
    } catch (e) {
      return 'Ce champ est obligatoire.';
    }
    return null;
  }

  void submit() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
    } else {
      form.save();
      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');

      Navigator.of(context).pushNamed(LoginPage.tag);
    }
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
    super.initState();

    _nameFocus = FocusNode();
    _phoneNumberFocus = FocusNode();
    _mailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _phoneNumberFocus.dispose();
    _mailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleForm = Text(
      'Vos informations',
      textAlign: TextAlign.center,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 32.0),
    );

    final name = TextFormField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        focusNode: _nameFocus,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _nameFocus, _phoneNumberFocus);
        },
        autofocus: false,
        decoration: InputDecoration(
          fillColor: Color.fromRGBO(62, 71, 80, 1),
          filled: true,
          prefixIcon: Icon(
            Icons.person,
            color: Colors.blueGrey,
          ),
          labelText: "Nom d'utilisateur",
          hintText: "Veuillez saisir votre nom d'utilisateur",
          hintStyle: TextStyle(color: Colors.blueGrey),
          labelStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(),
        ),
        validator: this._confirmData,
        onSaved: (String value) {
          this._data.name = value;
        });

    final phoneNumber = TextFormField(
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        focusNode: _phoneNumberFocus,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _phoneNumberFocus, _mailFocus);
        },
        autofocus: false,
        decoration: InputDecoration(
          fillColor: Color.fromRGBO(62, 71, 80, 1),
          filled: true,
          prefixIcon: Icon(
            Icons.smartphone,
            color: Colors.blueGrey,
          ),
          labelText: 'Numéro de téléphone',
          hintText: 'Veuillez saisir votre numéro de téléphone',
          hintStyle: TextStyle(color: Colors.blueGrey),
          labelStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(),
        ),
        validator: this._confirmData,
        onSaved: (String value) {
          this._data.password = value;
        });

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
            Icons.mail,
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
        textInputAction: TextInputAction.next,
        focusNode: _passwordFocus,
        onFieldSubmitted: (value) {
          _fieldFocusChange(context, _passwordFocus, _confirmPasswordFocus);
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
          helperText: 'No more than 8 characters.',
          hintStyle: TextStyle(color: Colors.blueGrey),
          labelStyle: TextStyle(color: Colors.blueGrey),
          helperStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(),
        ),
        validator: this._validatePassword,
        onSaved: (String value) {
          this._data.password = value;
        });

    final confirmPassword = TextFormField(
        textInputAction: TextInputAction.done,
        focusNode: _confirmPasswordFocus,
        onFieldSubmitted: (value) {
          _confirmPasswordFocus.unfocus();
        },
        autofocus: false,
        obscureText: _obscureText2,
        decoration: InputDecoration(
          fillColor: Color.fromRGBO(62, 71, 80, 1),
          filled: true,
          prefixIcon: Icon(
            Icons.beenhere,
            color: Colors.blueGrey,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              
              setState(() {
                _obscureText2 = !_obscureText2;
              });
            },
            child: Icon(
              _obscureText2 ? Icons.visibility : Icons.visibility_off,
              semanticLabel: _obscureText2 ? 'show password' : 'hide password',
              color: Colors.blueGrey,
            ),
          ),
          labelText: 'Confirmation',
          hintText: 'Veuillez confirmer votre mot de passe',
          hintStyle: TextStyle(color: Colors.blueGrey),
          labelStyle: TextStyle(color: Colors.blueGrey),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(),
        ),
        validator: this._confirmPassword);

    final registerButton = RaisedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enregistrer  ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          Icon(
            Icons.arrow_forward,
            color: Colors.white,
          )
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      color: Theme.of(context).primaryColor,
      onPressed: () {
        this.submit();
      },
      splashColor: Colors.orangeAccent,
    );

    final backButton = IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      iconSize: 30.0,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return Scaffold(
        backgroundColor: Color.fromRGBO(52, 59, 69, 1),
        body: Center(
          child: Form(
            key: this._formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [backButton, titleForm]),
                SizedBox(height: 10.0),
                SizedBox(height: 10.0),
                name,
                SizedBox(height: 10.0),
                phoneNumber,
                SizedBox(height: 10.0),
                email,
                SizedBox(height: 10.0),
                password,
                SizedBox(height: 8.0),
                confirmPassword,
                SizedBox(height: 30.0),
                registerButton,
                SizedBox(height: 25.0),
                Text(
                  '*Tous les champs sont requis.',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 11.0),
                ),
              ],
            ),
          ),
        ));
  }
}
