import 'package:baduk1234/home_page.dart';
import 'package:flutter/material.dart';

import 'constants/matirial_white.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomePage(),
        theme: ThemeData(primarySwatch: white),
    );
  }
}
