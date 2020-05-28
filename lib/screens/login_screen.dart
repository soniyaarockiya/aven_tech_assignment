import 'package:flutter/material.dart';
import 'package:aventech_assignment/services/form_validation.dart';

const kInActiveColor = Colors.grey;

class LoginPage extends StatefulWidget {
  final VoidCallback onSignedIn;

  LoginPage({this.onSignedIn});

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }
enum UserType { student, staff }

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  FormValidation _formValidation = new FormValidation();

  String email;
  String password;

  //WE WILL USE FORMTYPE VAR TO SWITCH WIDGET ON SCREEN
  FormType _formType = FormType.login;
  UserType _userType = UserType.student;

  void validateAndSubmit() async {
    try {
      String userId = await _formValidation.validateAndSubmit(
          email, password, formKey, _formType);
      if (userId != null) {
        widget.onSignedIn();
      }
    } catch (e) {
      print(e);
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
        title: Text(
          'Login Page',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200.0,
                    child: Image.asset('lib/images/leaf.png'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: _userType != UserType.student
                            ? kInActiveColor
                            : null,
                        child: Text('Student'),
                        onPressed: () {
                          setState(() {
                            _userType = UserType.student;
                          });
                        },
                      ),
                      RaisedButton(
                        color:
                            _userType != UserType.staff ? kInActiveColor : null,
                        child: Text('Staff'),
                        onPressed: () {
                          setState(() {
                            _userType = UserType.staff;
                          });
                        },
                      ),
                    ],
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: buildInputs() + buildSubmitButtons(),
                    ),
                  ),
                ],
              ),
            ),
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
      if (_userType == UserType.staff) {
        return [
          Container(
            child: RaisedButton(
              onPressed: validateAndSubmit,
              child: Text(
                'Staff Login',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ];
      }
      return [
        Container(
          child: RaisedButton(
            onPressed: validateAndSubmit,
            child: Text(
              'Student Login',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        Container(
          child: FlatButton(
            onPressed: moveToRegister,
            child: Text(
              'Register as new user',
            ),
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
