import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registroqrs/src/pages/login/login_helper.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:registroqrs/src/pages/perfil/perfil_screen.dart';
import 'package:registroqrs/src/pages/production/produccion_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginHelper());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Obx(() {
          if (controller.googleAccount.value == null) {
            return Login(controller: controller);
          } else {
            return ProduccionScreen();
            //return PerfilScreen();
          }
        }),
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginHelper controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            "CONTROL",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: Colors.teal,
            ),
          ),
          const SizedBox(
            height: 35,
          ),/*
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Ingrese correo electrónico",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Introducir la contraseña",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: Icon(Icons.remove_red_eye),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {}, child: const Text("Contraseña olvidada?"))
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient:
                  const LinearGradient(colors: [Colors.blue, Colors.green]),
            ),
            child: MaterialButton(
              onPressed: () {},
              child: const Text(
                "INICIAR SESION",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Icon(
            Icons.fingerprint,
            size: 60,
            color: Colors.teal,
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 30,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No tengo una cuenta?",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              TextButton(
                  onPressed: () {}, child: const Text("Registrar Cuenta"))
            ],
            /*
            *+ DERECHA
            *-izquierda
            *cantidad sin autofocus
            *quitar cerrar sesion de la pantalla del perfil_screen y del menu
            *no mostrar el correo en el perfil_screen
            *perfi_screen por pantalla de bienvenida
            *perfil_screen por ahora no se usara, mostrar directo el registro de produccion
            */
          ),*/
          const SizedBox(
            height: 25,
          ),
          SignInButton(
            Buttons.Google,
            text: 'Iniciar con Google',
            padding: const EdgeInsets.all(4.0),
            elevation: 12.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onPressed: () {
              controller.signInWithGoogle();
            },
          )
        ],
      ),
    );
  }
}
