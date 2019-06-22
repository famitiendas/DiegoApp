import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/Dialogs.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/ResultadoFinal.dart';
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:localstorage/localstorage.dart';

class ResultadoMedio extends StatefulWidget {
  @override
  _ResultadoMedioState createState() => _ResultadoMedioState();
}

class _ResultadoMedioState extends State<ResultadoMedio> {
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = new LocalStorage('famitiendas');   
    
    int entradas = 0;
    return new StreamBuilder(
        stream: Firestore.instance.collection("calificaciones").snapshots(), 
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (entradas != 0) { 
            final String entrada =storage.getItem("codeClient"); 
            List<String> lista = [];
            List<String> listaIDS = [];
            for (var item in snapshot.data.documents) { 
              if (item.data["codeClient"] == entrada) { 
                storage.setItem("nameClient", item["nameClient"]); 
                lista.add(item["date"]);
                listaIDS.add(item.documentID);
              } 
            } 
            return lista.length != 0
                ? new Scaffold(
                    body: new ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new Row(mainAxisSize: MainAxisSize.min, children: [
                        GestureDetector(
                            onTap: () {
                              storage.setItem("idDocumento", listaIDS[index]);
                               Navigator.of(context).push(
                                  MaterialPageRoute(builder: (contexto) {
                                return new ResultadoFinal();
                              }));
                            },
                            child: Container(
                              margin: new EdgeInsets.only(
                                  top: 5.0, left: 5.0, right: 5),
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                border: Border.all(
                                  color: Colors.grey,
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
                                    width: 300,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new FittedBox(
                                          child: new Text(
                                            "Nombre del cliente: " +
                                                storage.getItem("nameClient")+"\nFecha calificación: " +
                                                lista[index],
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
                              "el cliente con codigo ${storage.getItem("codeClient")} \nno tiene calificaciones",
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
