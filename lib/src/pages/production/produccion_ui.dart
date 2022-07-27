import 'package:flutter/material.dart';
import 'package:registroqrs/src/pages/menu/menu_drawer.dart';
import 'package:registroqrs/src/pages/production/produccion_screen.dart';

class ProduccionUI extends StatefulWidget {
  static String id = "produccion_ui";

  @override
  State<ProduccionUI> createState() => _ProduccionUIState();
}

class _ProduccionUIState extends State<ProduccionUI> {
  //Poner el state para manejar el body mediante el menu, tonces usamos estados para actualizar nuestras vistas :3 recien se me ocurrio asi que ekizde XD
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Control Plus",
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
        body: ProduccionScreen(),
      ),
    );
  }
}
