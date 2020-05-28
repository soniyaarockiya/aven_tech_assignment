import 'package:flutter/material.dart';
import 'package:aventech_assignment/services/authentication.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onSignedIn;

  LoginPage({this.onSignedIn});

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  BaseAuth _auth = new Auth();
  final formKey = new GlobalKey<FormState>();

  String email;
  String password;

  //WE WILL USE FORMTYPE VAR TO SWITCH WIDGET ON SCREEN
  FormType _formType = FormType.login;

  //
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      //if you don't save the form , it returns null for both email and password
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
//          FirebaseUser user = (await FirebaseAuth.instance
//              .signInWithEmailAndPassword(email: email, password: password))
//              .user;

          String userId =
              await _auth.signInWithEmailAndPassword(email, password);

          print("Signed in as : $userId");
        } else {
//          FirebaseUser user = (await FirebaseAuth.instance
//              .createUserWithEmailAndPassword(email: email, password: password))
//              .user;

          String userId =
              await _auth.createUserWithEmailAndPassword(email, password);

          print("Registered in as : $userId");
        }

        widget.onSignedIn();
      } catch (e) {
        print("Error :  $e");
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onLongPress: () {
            // print("double tap working");
            // //return AdminPage;

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => LiveOrders(),
            //     ));
          },
          child: Text(
            'Login Page User',
          ),
        ),
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Enter your email',
        ),
        validator: (value) => value.isEmpty ? 'Email cant be empty' : null,
        onSaved: (value) => email = value,
      ),
      TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Enter the password',
        ),
        validator: (value) => value.isEmpty ? 'pass word cant be empty' : null,
        onSaved: (value) => password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          onPressed: validateAndSubmit,
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
        FlatButton(
          onPressed: moveToRegister,
          child: Text(
            'Register as new user',
          ),
        )
      ];
    }

    if (_formType == FormType.register) {
      return [
        RaisedButton(
          onPressed: validateAndSubmit,
          child: Text(
            'register',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
        FlatButton(
          onPressed: moveToLogin,
          child: Text(
            'Login existing user',
          ),
        )
      ];
    }
  }
}
