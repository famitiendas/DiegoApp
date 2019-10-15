import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/Calificacion.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/Notif.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/Notif.dart'
    as prefix0;
import 'package:flutter/material.dart';

import 'Dialogs.dart';
import 'login_screen.dart';

class CalificaCliente extends StatefulWidget {
  CalificaCliente({Key key}) : super(key: key);

  _CalificaClienteState createState() => _CalificaClienteState();
}

class _CalificaClienteState extends State<CalificaCliente> {
  final _formKey = GlobalKey<FormState>();
  bool loginEnabled;
  bool isVisible;
  int cantidad = 1;
  List<Respuestas> respuestas = [];
  var preguntas = [];
  var opciones = ["Si", "No"];

  BuildContext contexto;
  TextEditingController nombreCliente = new TextEditingController();
  TextEditingController codigoClient = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    contexto = context;
    void calificarClient() async {
      bool banderaRespuestas = false;
      preguntas.forEach((respuesta) => {
            if (respuesta == "") {banderaRespuestas = true}
          });
      if (!banderaRespuestas) {
        int contador = 0;
        List<String> respuestasString = [];
        for (Respuestas respuesta in respuestas) {
          respuesta.valor = preguntas[contador];
          contador++;
          //Respuestas resFin = new Respuestas.toSave(respuesta.pregunta, respuesta.valor);
          String resFin = '${respuesta.valor}';
          respuestasString.add(resFin);
        }
        try {
          Calification calification;
          Notificationd notification;
          var now = new DateTime.now();
          calification = new Calification.toSave("${nombreCliente.text}",
              "${codigoClient.text}", now.toString(), respuestasString);

          int contador = 1;
          Firestore.instance
              .collection("calificaciones")
              .getDocuments()
              .then((data1) {
            for (int i = 0; i < data1.documents.length; i++) {
              if (data1.documents[i].data["codeClient"] == codigoClient.text) {
                contador++;
              }
            }
            notification = new Notificationd.toSave(
                "${nombreCliente.text}", "${contador}", now.toString());
            Firestore.instance
                .collection('calificaciones')
                .document()
                .setData(calification.toJson())
                .then((data) {
              //nombre,fecha// visitas

              
                //nombre,fecha// visitas

                new Dialogs().showDialogNotificaciones(
                    "Exitoso",
                    "Tu calificación se ha guardado con exito",
                    context,
                    now.toString(),
                    calification.nameClient,
                    contador,
                    "-LhsEkrfprjtzx2g7QQb");
                //generar notificación
              });
          });
        } on Exception {
          new Dialogs().showDialogLogin("Error!", "erororoororor", context);
        }
      } else {
        new Dialogs().showDialogLogin("Error!",
            "No has llenado todas las respuestas del formulario", context);
      }
    }

    final number = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: nombreCliente,
      decoration: InputDecoration(
        hintText: 'Nombre Cliente',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = Visibility(
      //  visible: isVisible != null ? isVisible : true,
      child: TextFormField(
        autofocus: false,
        controller: codigoClient,
        //    controller: _passw,
        decoration: InputDecoration(
          hintText: 'Código Cliente',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 26.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          calificarClient();
        }, 
        color: Colors.lightBlueAccent,
        child:
            Text('Enviar Calificación', style: TextStyle(color: Colors.white)),
      ),
    );

    final cerrarSesion = Padding(
      padding: EdgeInsets.symmetric(vertical: 26.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(contexto).pushReplacement(MaterialPageRoute(builder: (contexto) {
              return new LoginScreen(); //ResultadoInicial
            }));
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child:
            Text('  Cerrar Sesión', style: TextStyle(color: Colors.white)),
      ),
    );
    final headerOptions = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text("Indicadores de seguimiento",
              style: TextStyle(color: Colors.black)),
        ),
        Expanded(
            child: Text(
          "Cumplimiento",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.end,
        )),
      ],
    );
    var entradas = 0;
    final listado = Container(
        height: MediaQuery.of(context).size.height * 0.45,
        child: StreamBuilder(
            stream: Firestore.instance.collection("preguntas").snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null || entradas != 0) {
                return snapshot.data.documents.length != 0
                    ? new Scaffold(
                        body: new Container(
                        height: MediaQuery.of(context).size.height * 0.99,
                        padding: EdgeInsets.all(2.0),
                        child: ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (preguntas.length <
                                  snapshot.data.documents.length) {
                                Respuestas respuesta = new Respuestas(
                                    "${snapshot.data.documents[index].data["Pregunta"]}",
                                    "${snapshot.data.documents[index].data["valor"]}");
                                respuestas.add(respuesta);
                                preguntas.add(snapshot
                                    .data.documents[index].data["valor"]);
                              }
                              return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                            child: Text(
                                              "${index + 1}.   ${snapshot.data.documents[index].data["Pregunta"]}",
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              child: DropdownButton(
                                                hint: new Text(
                                                  "${preguntas[index]}",
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                                items: opciones
                                                    .map((String value) =>
                                                        new DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: new Text(
                                                            value,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ))
                                                    .toList(),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    preguntas[index] = newValue;
                                                    //value = newValue;
                                                    //bank = newValue;
                                                  });
                                                },
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      )
                                    ],
                                  ));
                            }),
                        color: Colors.white,
                      ))
                    : new Scaffold(
                        body: new Container(
                          height: 150.0,
                          margin: EdgeInsets.all(60.0),
                          decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              border: Border.all(
                                color: Colors.black87,
                                width: 0.9,
                              )),
                          child: new Column(
                            children: <Widget>[
                              new Text(
                                "No tienes preguntas",
                                maxLines: 1000,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              new Icon(
                                Icons.announcement,
                                size: 80.0,
                                color: Color(0xFF00BCD4),
                              )
                            ],
                          ),
                        ),
                      );
              } else {
                entradas++;
                return new Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            new Center(
              child: new Column(
                children: <Widget>[
                  number,
                  SizedBox(height: 18.0),
                  password,
                  SizedBox(
                    height: 18.0,
                  ),
                  headerOptions,
                  listado,
                  SizedBox(height: 5),
                  loginButton,
                  SizedBox(width: 5),
                  cerrarSesion
                ],
              ),
            ),
            SizedBox(
              height: 98.0,
            ),
          ],
        ),
      ),
    );
  }
}
