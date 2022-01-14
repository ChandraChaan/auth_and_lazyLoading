import 'package:flutter/material.dart';

import 'blastAnimation.dart';
import 'checkAuth.dart';
import 'lazyLoadingList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Test Jakee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: authCheck(),
    );
  }
}
