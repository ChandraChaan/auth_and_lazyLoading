import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class authCheck extends StatefulWidget {
  @override
  State<authCheck> createState() => _authCheckState();
}

class _authCheckState extends State<authCheck> {
  bool _hasBioSensor = false;
  bool verifiedUserThis = false;
  LocalAuthentication localAuth = LocalAuthentication();

  Future<void> _checkAuth() async {
    try {
      _hasBioSensor = await localAuth.canCheckBiometrics;
      setState(() {});
      if (_hasBioSensor == true) {
        _getAuth();
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _getAuth() async {
    bool confirmAuth = false;
    try {
      confirmAuth = await localAuth.authenticate(
          localizedReason: 'i need to confirm you');
      print(confirmAuth);
      verifiedUserThis = confirmAuth;
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
          verifiedUserThis == true ? Navigator.pop(context) : _checkAuth();
        },
        child: verifiedUserThis == true
            ? Text(
                'Authentication Done, \nThanks you, \nclick here to go back')
            : Text('Check Auth'),
      )),
    );
  }
}
