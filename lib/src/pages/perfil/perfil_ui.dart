/*
*LOGIN GUI
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registroqrs/src/pages/login/login_helper.dart';
import 'package:registroqrs/src/pages/menu/menu_drawer.dart';
import 'package:registroqrs/src/pages/perfil/perfil_screen.dart';

/*
*CONTROLADOR DE LOGIN
*/
final controller = Get.put(LoginHelper());
/*
*VALIDADOR DEL MENU
*/

class PerfilUI extends StatefulWidget {
  static String id = "login_ui";

  @override
  State<PerfilUI> createState() => _PerfilUIState();
}

class _PerfilUIState extends State<PerfilUI> {
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
        body: PerfilScreen(),
      ),
    );
  }
}
