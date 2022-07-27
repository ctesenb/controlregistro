import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registroqrs/src/pages/login/login_helper.dart';

class PerfilScreen extends StatefulWidget {
  PerfilScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

final controller = Get.put(LoginHelper());

String formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Perfil()); //Perfil();
  }
}

class Perfil extends StatelessWidget {
  const Perfil({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Perfil",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      controller.googleAccount.value?.photoUrl ?? '',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                initialValue: controller.googleAccount.value?.displayName,
                readOnly: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Correo electrónico",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                initialValue: controller.googleAccount.value?.email,
                readOnly: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Fecha de Hoy",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                initialValue:
                    //Formato de fecha DIA MES ANO
                    formatDate(DateTime.now()),
                readOnly: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                label: Text("Cerrar sesión"),
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  if (controller.googleAccount.value != null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Cerrar sesión"),
                        content:
                            const Text("¿Está seguro que desea cerrar sesión?"),
                        actions: [
                          ElevatedButton(
                            child: const Text("Cancelar"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          ElevatedButton(
                            child: const Text("Cerrar sesión"),
                            onPressed: () {
                              controller.signOutWithGoogle();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
