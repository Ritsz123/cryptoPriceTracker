import 'package:flutter/material.dart';
import 'package:flutter_crypto/homePage.dart';
import 'package:flutter_crypto/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      home: HomePage(),
    );
  }
}
