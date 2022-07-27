import 'package:flutter/material.dart';
import 'package:registroqrs/src/pages/login/login_screen.dart';
import 'package:registroqrs/src/pages/menu/menu_drawer.dart';
import 'package:registroqrs/src/pages/production/produccion_screen.dart';

/*
*LOGIN GUI
*/
class LoginUI extends StatefulWidget {
  static String id = "login_ui";

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Control PLus",
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/icons/logo-control-plus.png',
            height: 40,
          ),
        ),
        drawer: MenuLateral(),
        body: LoginScreen(),
      ),
    );
  }
}
