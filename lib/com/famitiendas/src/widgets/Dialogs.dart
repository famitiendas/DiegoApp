import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/entities/notification_data.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/utils/Notifications.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/CalificarCliente.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/ResultadoFinal.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'menu.dart';

class Dialogs {
  BuildContext contexto;
  void showDialogLogin(String resultado, String mensaje, BuildContext context) {
    // flutter defined function
    contexto = context;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("$resultado"),
          content: new Text("$mensaje"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Aceptar"),
              onPressed: () {
                Navigator.of(context).pop();
                if (resultado == "Exitoso") {
                  Navigator.of(contexto)
                      .pushReplacement(MaterialPageRoute(builder: (contexto) {
                    return new Menu();
                  }));
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showDialogRecibirNotificacion(
      String fecha,
      String nombreAsesor,
      int numerovisitas,
      String idDocument,
      String resultado,
      String mensaje,
      BuildContext context) {
    // flutter defined function
    contexto = context;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Bienvenido"),
          content: new Text("¿Qué desea hacer con la notificación?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ver"),
              onPressed: () {
                Firestore.instance
                    .collection('calificaciones')
                    .getDocuments()
                    .then((data) {
                  for (int i = 0; i < data.documents.length; i++) {
                    if (data.documents[i].documentID == idDocument) {
                      LocalStorage storage = new LocalStorage('famitiendas');
                      storage.setItem(
                          "nameClient", data.documents[i].data["nameClient"]);
                      storage.setItem(
                          "codeClient", data.documents[i].data["codeClient"]);
                      storage.setItem("idDocumento", idDocument);
                    }
                  }
                });
                Navigator.of(context).pop();
                Navigator.of(contexto)
                    .push(MaterialPageRoute(builder: (contexto) {
                  return new ResultadoFinal();
                }));
              },
            ),
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showDialogNotificaciones(
      String resultado,
      String mensaje,
      BuildContext context,
      String fecha,
      String nombre,
      int visitas,
      String document) {
    // flutter defined function
    contexto = context;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("$resultado"),
          content: new Text("$mensaje"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Aceptar"),
              onPressed: () {
                Navigator.of(context).pop();
                LocalStorage storage = new LocalStorage('famitiendas');
                NotificationData notificationData = new NotificationData.toSave(
                    DateTime.now().toString(), storage.getItem("user"), visitas,nombre);
                saveNotifications(notificationData);
                Firestore.instance
                    .collection('calificaciones')
                    .getDocuments()
                    .then((data1) {
                  for (int ji = 0; ji < data1.documents.length; ji++) {
                    if (data1.documents[ji].data["nameClient"] == nombre &&
                        data1.documents[ji].data["date"] == fecha) {
                      Firestore.instance
                          .collection('usuarios')
                          .getDocuments()
                          .then((data) { 
                            List<String> players=[];
                        for (int i = 0; i < data.documents.length; i++) {
                         
                          if (data.documents[i].data["admin"]) {
                            if(data.documents[i].data["playerID"]!= ""){
                              players.add(data.documents[i].data["playerID"]);
                            }
                            
                          }
                          if((i+1) == data.documents.length && players.length != 0){
                            new NotificationManager().handleSendNotification(
                                fecha,
                                nombre,
                                visitas,
                                players,
                                data1.documents[ji].documentID);
                          }
                        }
                      });
                    }
                  }
                });

                //aqui va el metodo 
                if (storage.getItem("admin")) {
                  Navigator.of(contexto)
                      .pushReplacement(MaterialPageRoute(builder: (contexto) {
                    return new Menu();
                  }));
                } else {
                  Navigator.of(contexto)
                      .pushReplacement(MaterialPageRoute(builder: (contexto) {
                    return new CalificaCliente();
                  }));
                }
              },
            ),
          ],
        );
      },
    );
  }

  void saveNotifications(NotificationData notification) async {
    await Firestore.instance
        .collection('usuarios')
        .document("notif")
        .collection('Notificaciones')
        .document()
        .setData(notification.toJson())
        .then((notif) {
      print('saved succesfully notification');
    }).catchError((error) => print(error));
  }
}
