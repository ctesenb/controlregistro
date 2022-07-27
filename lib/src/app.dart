import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:registroqrs/src/pages/login/login_ui.dart';
import 'package:registroqrs/src/pages/perfil/perfil_ui.dart';
import 'package:registroqrs/src/pages/production/produccion_ui.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Info Plus',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: AnimatedSplashScreen(
        splash: 'assets/icons/logo-control-plus.png',
        nextScreen: LoginUI(),
        splashTransition: SplashTransition.rotationTransition,
        pageTransitionType: PageTransitionType.fade,
      ),
      routes: {
        LoginUI.id: (context) => LoginUI(),
        PerfilUI.id: (context) => PerfilUI(),
        ProduccionUI.id: (context) => ProduccionUI(),
      },
    );
  }
}
