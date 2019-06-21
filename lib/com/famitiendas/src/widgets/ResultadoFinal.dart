import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/Calificacion.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'Dialogs.dart';

class ResultadoFinal extends StatefulWidget {
  ResultadoFinal({Key key}) : super(key: key);

  _ResultadoFinalState createState() => _ResultadoFinalState();
}

class _ResultadoFinalState extends State<ResultadoFinal> {
  final _formKey = GlobalKey<FormState>();
  bool loginEnabled;
  bool isVisible;
  int cantidad = 1;
  var preguntas = [];
  int valor = 0;
  var opciones = ["Si", "No"];

  BuildContext contexto;
  TextEditingController nombreCliente = new TextEditingController();
  TextEditingController codigoClient = new TextEditingController();

  void getData() async {
    Firestore.instance.collection('preguntas').getDocuments().then((data) {
      for (int i = 0; i < data.documents.length; i++) {
        preguntas.add(data.documents[i].data["Pregunta"]);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    LocalStorage storage = new LocalStorage('famitiendas');
    contexto = context;
  bool enter=false;
    getData();
    if (preguntas.length != 0) {
      final number = Text(
        "Nombre del cliente: " + storage.getItem("nameClient"),
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.end,
      );
      final password = Text(
        "Código del cliente: " + storage.getItem("codeClient"),
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.end,
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
          height: MediaQuery.of(context).size.height * 0.55,
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection("calificaciones")
                  .document(storage.getItem("idDocumento"))
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                valor=0;
                if (snapshot.data != null || entradas != 0) {
                  return snapshot.data["listResp"].length != 0
                      ? new Scaffold(
                          body: new Container(
                          height: MediaQuery.of(context).size.height * 0.99,
                          padding: EdgeInsets.all(2.0),
                          child: ListView.builder(
                              itemCount: snapshot.data["listResp"].length,
                              itemBuilder: (BuildContext context, int index) {
                                if (snapshot.data["listResp"][index] ==
                                    "Si" && !enter) {
                                  valor++;
                                }
                                if(snapshot.data["listResp"].length == 12){
                                  enter=true;
                                }
                                return Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.all(6.0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.65,
                                              child: Text(
                                                "${index + 1}.   ${preguntas[index]}",
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
                                                  0.1,
                                              child: new Text(
                                                "${snapshot.data["listResp"][index]}",
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                              ),
                                            ),
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
                  getData();
                  entradas++;
                  return new Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }));

      final resultadoFinalEncuesta = Text(
        "Resultado ${(valor / 12) * 100}% de 100% ",
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.end,
      );

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
                    SizedBox(
                      height: 18.0,
                    ),
                    resultadoFinalEncuesta
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
    } else {
      return new Scaffold(
          body: new Center(
        child: CircularProgressIndicator(),
      ));
    }
  }
}
