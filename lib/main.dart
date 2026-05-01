import 'package:flutter/material.dart';
import 'package:yemek_dunyasi/aboutUsers/landingScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yemek Dünyası',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        body: Center(
          child: LandingScreen(),
        ),
      ),
    );
  }
}


