import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Notificaciones extends StatefulWidget {
  Notificaciones({Key key}) : super(key: key);

  _NotificacionesState createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificaciones> {
  String _nombreAsesor;

  final nombre_asesor = new Text("_nombreAsesor");
  final numero_visitas = new Text("data");

  final contenedor_notif = new Container(
    child: Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text("EL ASESOR"),
            new Text("data"),
            new Text("data"),
            new Text("data")
          ],
        ),
        Column(
          children: <Widget>[new Text("data"), new Text("data")],
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    var entradas = 0;
    final _label_asesor = Text(
      'El Asesor ',
      style: TextStyle(fontSize: 14.0, color: Colors.blueAccent),
    );
    final _label_vendedor = Text(
      'ha calificado al vendedor  ',
      style: TextStyle(fontSize: 14.0, color: Colors.blueAccent),
    );
    final _label_visitas = Text(
      'Le han realizado ',
      style: TextStyle(fontSize: 14.0, color: Colors.blueAccent),
    );
    final _label_fecha = Text(
      'Fecha ',
      style: TextStyle(fontSize: 14.0, color: Colors.blueAccent),
    );
    return StreamBuilder(
      stream: Firestore.instance
          .collection("usuarios")
          .document("notif")
          .collection("Notificaciones")
          .orderBy("fecha", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data != null && entradas != 0) {
          return snapshot.data.documents.length != 0
              ? Scaffold(
                  body: new Container(
                    height: MediaQuery.of(context).size.height * 0.99,
                    padding: EdgeInsets.all(2.0),
                    child: ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          String item = "";
                          if (snapshot.data.documents[index].data["fecha"] !=
                              null) {
                            item =
                                "${new DateFormat.yMMMd().format(DateTime.parse(snapshot.data.documents[index].data["fecha"]))}";
                          }
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(
                                height: 12.0,
                              ),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                onPressed: () {},
                                color: Colors.lightBlueAccent,
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: _label_asesor,
                                              flex: 50,
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${snapshot.data.documents[index].data["nombreAsesor"]}',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.grey),
                                              ),
                                              flex: 50,
                                            ),
                                            Expanded(
                                              child: _label_vendedor,
                                              flex: 50,
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${snapshot.data.documents[index].data["vendedor"]}',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.grey),
                                              ),
                                              flex: 50,
                                            ),
                                            Expanded(
                                              child: _label_visitas,
                                              flex: 50,
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${snapshot.data.documents[index].data["numeroVisitas"]}' +
                                                    ' Visitas',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.grey),
                                              ),
                                              flex: 50,
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: _label_fecha,
                                                    flex: 50,
                                                  ),
                                                  Text(
                                                    '$item',
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color:
                                                            Colors.green[600]),
                                                  )
                                                ],
                                              ),
                                              flex: 50,
                                            )
                                          ],
                                        ),
                                        flex: 50,
                                      ),
                                    ],
                                  ),
                                  color: Colors.white,
                                  width:
                                      MediaQuery.of(context).size.width * 0.90,
                                  height:
                                      MediaQuery.of(context).size.height * 0.18,
                                  margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.02,
                                    left: MediaQuery.of(context).size.height *
                                        0.02,
                                    right: MediaQuery.of(context).size.height *
                                        0.02,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 6.0,
                              ),
                            ],
                          );
                        }),
                    color: Colors.white30,
                  ),
                )
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
                          "No tienes notificaciones pendientes",
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
      },
    );
  }
}
