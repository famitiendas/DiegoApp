import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/Dialogs.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/ResultadoMedio.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class ResultadoInicial extends StatefulWidget {
  @override
  _ResultadoInicialState createState() => _ResultadoInicialState();
}

class _ResultadoInicialState extends State<ResultadoInicial> {
  @override
  Widget build(BuildContext context) {
    int entradas = 0;
    List<String> codes = [];
    return new StreamBuilder(
        stream: Firestore.instance.collection("calificaciones").snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (entradas != 0) {
            codes = [];
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              if (!codes.contains(snapshot.data.documents[i]["codeClient"])) {
                codes.add(snapshot.data.documents[i]["codeClient"]);
              }
            }
            return snapshot.data.documents.length != 0
                ? new Scaffold(
                    body: new ListView.builder(
                    itemCount: codes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new Row(mainAxisSize: MainAxisSize.min, children: [
                        GestureDetector(
                            onTap: () {
                              LocalStorage storage =
                                  new LocalStorage('famitiendas');
                              storage.setItem("codeClient",
                                  codes[index]);
                              storage.setItem("nameClient",
                                  snapshot.data.documents[index]["nameClient"]);
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (contexto) {
                                return new ResultadoMedio();
                              }));
                            },
                            child: Container(
                              margin: new EdgeInsets.only(
                                  top: 5.0, left: 5.0, right: 5,bottom: 5.0),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        24.0) //                 <--- border radius here
                                    ),
                              ),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Container(
                                    margin:
                                        EdgeInsets.only(left: 20.0, top: 20.0),
                                    width: 150,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new FittedBox(
                                          child: new Text(
                                            "Código del cliente: " +
                                                codes[index],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 26.0),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ]);
                    },
                  ))
                : new Scaffold(
                    body: new Container(
                      height: 150.0,
                      width: MediaQuery.of(context).size.width * 80,
                      margin: EdgeInsets.all(60.0),
                      decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          border: Border.all(
                            color: Colors.black12,
                            width: 0.2,
                          )),
                      child: new Column(
                        children: <Widget>[
                          new SizedBox(height: 10),
                          new FittedBox(
                            child: new Text(
                              "No tienes calificaciones\n de clientes disponibles.",
                              maxLines: 1000,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          new Icon(
                            Icons.info,
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
              child: new CircularProgressIndicator(),
            );
          }
        });
  }
}
