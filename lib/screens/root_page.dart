import 'package:aventech_assignment/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:aventech_assignment/screens/home_screen.dart';
import 'package:aventech_assignment/screens/login_screen.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;
  BaseAuth _auth = new Auth();

  //INIT STATE IS CALLED  BEFORE THE BUILD , HENCE WE CHECK THE STATUS OF THE USER
  // HERE FIRST AND ACCORDINGLY DISPLAY THE RELEVANT SCREEN
  @override
  void initState() {
    super.initState();
    //ROOT PAGE CHECKS IF USER IS LOGGED IN OR NOT AND ACCORDINGLY CHANGES THE AUTH STATUS VAR ,
    // THEN THE BUILD METHOD IS CALLED

    _auth.currentUser().then((userId) {
      setState(() {
        _authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      //IF USER IS NOT LOGGED IN , OPEN LOGIN SCREEN
      case AuthStatus.notSignedIn:
        return LoginPage(onSignedIn: _signedIn);
      //IF USER IS LOGGED IN , OPEN HOME SCREEN
      case AuthStatus.signedIn:
        return HomePage(onSignedOutHome: _signedOut);
      // HomePage( onSignedOutHome: _signedOut);
    }
  }

  // BOTH THESE METHODS ARE INVOKED FROM THE LOGIN PAGE AND HOME PAGE RESPECTIVELY,
  // BY CALL BACK METHODS.
  //HENCE BOTH  LOGIN AND HOME PAGE ARE ASSIGNED SECOND PARAMETERS HERE TO RECEIVE THE
  // CALL BACK FROM THE LOGIN PAGE AND HOME
  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }
}
