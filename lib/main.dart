import 'package:flutter/material.dart';
import 'package:rifasonline/screens/Home.dart';
import 'package:rifasonline/screens/SplashScreen.dart';
import 'package:rifasonline/variaveis.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contabilize',
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => Home()
      },
    );
  }
}
