import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:registroqrs/src/connection/db.dart';
import 'package:registroqrs/src/pages/login/login_helper.dart';
import 'package:registroqrs/src/services/horaactual.dart';
import 'package:majascan/majascan.dart';
import 'package:registroqrs/src/utils/notificaciones.util.dart' as util;

class ProduccionScreen extends StatefulWidget {
  ProduccionScreen({Key? key}) : super(key: key);

  @override
  State<ProduccionScreen> createState() => _ProduccionScreenState();
}

class _ProduccionScreenState extends State<ProduccionScreen> {
  final controller = Get.put(LoginHelper());
  int state = 0;
  String result = 'Escanear...';
  var codProducto = TextEditingController();
  var nomProducto = TextEditingController();
  var cantProducto = TextEditingController();
  var idgoogle;
  String fechahora = '';
  var cantidad;
  bool isButtonActive = false;
  @override
  void initState() {
    super.initState();
    cantidad = cantProducto.text.isEmpty ? double.parse(0.01.toStringAsFixed(2)) : double.parse(cantProducto.text);
  }

  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    codProducto.dispose();
    nomProducto.dispose();
    cantProducto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Registro\nde\nProducción\n",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Colors.teal,
                ),
                //centrar texto
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: InkWell(
                      splashColor: Colors.lightGreen,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.qr_code_scanner,
                              color: Colors.white, size: 60),
                          Text("Escanear QR"), // text
                        ],
                      ),
                    ),
                    onPressed: () {
                      abrirMajaScan();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Codigo del Producto',
                ),
                controller: codProducto,
                readOnly: true,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre del Producto',
                ),
                controller: nomProducto,
                readOnly: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                //alinear contenido al centro
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text(
                      '-',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        cantidad-= double.parse(0.01.toStringAsFixed(2));
                        if (cantidad < 0.01) {
                          cantidad = double.parse(0.01.toStringAsFixed(2));
                          util.mostraralerta(
                              context, 'Error', 'No puede ser menor a 1');
                        }
                        cantProducto.text = double.parse(cantidad.toStringAsFixed(2)).toString();
                      });
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  //Box pequeno de texto para ingresar cantidad
                  Container(
                    width: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cantidad',
                      ),
                      controller: cantProducto,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    child: const Text(
                      '+',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        cantidad = cantProducto.text.isEmpty
                            ? 0.01.toStringAsFixed(2)
                            : double.parse(cantProducto.text);
                        cantidad+= double.parse(0.01.toStringAsFixed(2));
                        //double.parse(num1.toStringAsFixed(2));
                        cantProducto.text = cantidad.toStringAsFixed(2).toString();
                      });
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: InkWell(
                      splashColor: Colors.lightGreen,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.app_registration,
                              color: Colors.white, size: 40), // icon
                          Text("Registrar Producto"), // text
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      onSurface: Colors.green,
                    ),
                    onPressed: isButtonActive ? () {
                      if (codProducto.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Debe ingresar un codigo de producto',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: Duration(seconds: 2),
                        );
                      } else if (cantProducto.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Debe ingresar una cantidad',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: Duration(seconds: 2),
                        );
                      } else {
                        cantidad = cantProducto.text.isEmpty
                            ? double.parse(0.01.toStringAsFixed(2))
                            : double.parse(cantProducto.text);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirmar Registro'),
                              content: Text(
                                '¿Esta seguro de registrar: $nombreProducto | $cantidad?',
                              ),
                              actions: [
                                ElevatedButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('Aceptar'),
                                  onPressed: () {
                                    getTime();
                                    postPro();
                                    Get.back();
                                    setState(() {
                                      cantidad = 1;
                                      isButtonActive = false;
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } : null,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  abrirMajaScan() async {
    try {
      String? qrResult = await MajaScan.startScan(
        title: 'Escanear...',
        titleColor: Colors.amberAccent[700],
        qRCornerColor: Colors.orange,
        qRScannerColor: Colors.orange,
      );
      setState(() {
        result = qrResult ?? 'Escaneo Invalido';
        var temp = result.split(",");
        String codigo = temp[0];
        codProducto.text = codigo;
        getNomPro();
        isButtonActive = true;
      });
      print(result);
    } on PlatformException catch (e) {
      if (e.code == MajaScan.CameraAccessDenied) {
        setState(() {
          util.mostraralerta(
              context, 'Alerta', 'No se puede acceder a la camara');
        });
      } else {
        setState(() {
          util.mostraralerta(context, 'Alerta', 'Escaneo invalido $e');
        });
      }
    } on FormatException {
      setState(() {
        util.mostraralerta(context, 'Alerta', 'Escaneo invalido');
      });
    } catch (e) {
      setState(() {
        util.mostraralerta(context, 'Alerta', 'Error: $e');
      });
    }
  }

  var existe = 0;
  var db = Mysql();
  var nombreProducto = '';

  void getNomPro() async {
    var temp = result.split(",");
    String codigo = temp[0];
    try {
      db.getConnection().then((conn) {
        String sql = "SELECT F5NOMPRO FROM IF5PLA WHERE F5CODPRO = '$codigo'";
        conn.query(sql).then((result) {
          for (var row in result) {
            nombreProducto = row[0];
            print(existe);
            print(row[0]);
            existe = 1;
            nomProducto.text = nombreProducto;
            cantProducto.text = cantidad.toStringAsFixed(2);
          }
          setState(() {
            existe = 1;
          });
        });
      });
    } catch (e) {
      util.mostraralerta(context, 'Alerta', '$codigo | Producto no existe');
      codProducto.text = '';
    }
  }

  void postPro() async {
    var temp = result.split(",");
    String codigo = temp[0];
    if (existe == 1) {
      db.getConnection().then((conn) {
        idgoogle = controller.googleAccount.value?.email;
        var oc = null;
        print(idgoogle);
        String fecha = DateFormat('yyyy-MM-dd').format(DateTime.now());
        print('Hora Actual:' + horaActual);
        fechahora = fecha + " " + horaActual;
        print('Fecha y Hora: ' + fechahora);
        var cant  = cantProducto.text.isEmpty
                            ? double.parse(0.01.toStringAsFixed(2))
                            : double.parse(cantProducto.text).round();
        
        String sql =
            "INSERT INTO QrEnvasadoCab (fechaHora, id_google,codPro,cantidad) VALUES ('$fechahora','$idgoogle','$codigo','$cant')";
        conn.query(sql).then((result) {
          print('Registro Exitoso');
          print(result);
          setState(() {
            util.mostraralerta(context, 'Alerta',
                '$codigo | Producto registrado correctamente');
            codProducto.text = '';
            nomProducto.text = '';
            cantProducto.text = '';
          });
        });
      });
    } else {
      setState(() {
        util.mostraralerta(context, 'Alerta', '$codigo | Producto no existe');
        codProducto.text = '';
      });
    }
  }
}
