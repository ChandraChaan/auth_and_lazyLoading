import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'lazyLoadingList.dart';

class authCheck extends StatefulWidget {
  @override
  State<authCheck> createState() => _authCheckState();
}

class _authCheckState extends State<authCheck> {
  bool _hasBioSensor = false;
  bool verifiedUserThis = false;
  String mainText = 'Check Auth';
  LocalAuthentication localAuth = LocalAuthentication();

  @override
  void initState() {
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    try {
      _hasBioSensor = await localAuth.canCheckBiometrics;
      setState(() {});
      if (_hasBioSensor == true) {
        _getAuth();
      } else {
        setState(() {
          mainText = 'you don\'t have Screen lock you can skip this. \nclick here to go next';
        });
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _getAuth() async {
    bool confirmAuth = false;
    try {
      confirmAuth = await localAuth.authenticate(
          localizedReason: 'i need to confirm you', stickyAuth: true);
      print(confirmAuth);
      verifiedUserThis = confirmAuth;
      if (confirmAuth == true)
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => jakes()));
      setState(() {});
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        onPressed: () {
          verifiedUserThis == true
              ? (Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => jakes())))
              : _checkAuth();
        },
        child: verifiedUserThis == true
            ? Text('Authentication Done, \nThanks you, \nclick here to go back')
            : Text(mainText),
      )),
    );
  }
}
