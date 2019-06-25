import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/entities/push_deliver.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/Dialogs.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/notificaciones.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'CalificarCliente.dart';
import 'ResultadoInicial.dart';
import 'package:onesignal/onesignal.dart';

class Menu extends StatefulWidget {
  static String tag = 'Menu';

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Menu(),
    );
  }

  //f990f412-702a-4d15-ac28-f6980de8de0a
  Menu({Key key}) : super(key: key);

  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  BuildContext contexto;
  String _debugLabelString = "";
  String _externalUserId;
  bool _enableConsentButton = false;
  bool _requireConsent = true;

  var deliver = PushDeliver();

  @override
  void initState() {
    initOneSignal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    contexto = context;
    void rediretClient() {
      print('Hola mundo rediretClient');
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (contexto) {
        return new CalificaCliente();
      }));
    }

    final calificarClientew = Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(16.0)),
          onPressed: () {
            rediretClient();
          },
          padding: EdgeInsets.all(12),
          color: Colors.lightBlueAccent,
          child: new Container(
            height: 80.0,
            width: 220.0,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Center(
                      child: new Image.asset(
                        'assets/man.png',
                        height: 80.0,
                        width: 70.0,
                      ),
                    ),
                  ],
                ),
                new Column(
                  children: <Widget>[
                    SizedBox(
                      height: 18.0,
                    ),
                    new Padding(
                      padding: EdgeInsets.only(left: 14.0, top: 10.0),
                      child: new Text('Calificar Cliente',
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.0)),
                    ),
                  ],
                )
              ],
            ),
          )),
    );

    final notificaciones = Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(16.0)),
          onPressed: () {
            Navigator.of(contexto).push(MaterialPageRoute(builder: (contexto) {
              return new Notificaciones(); //ResultadoInicial
            }));
          },
          padding: EdgeInsets.all(12),
          color: Colors.lightBlueAccent,
          child: new Container(
            height: 80.0,
            width: 220.0,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Center(
                      child: new Image.asset(
                        'assets/email.png',
                        height: 80.0,
                        width: 70.0,
                      ),
                    ),
                  ],
                ),
                new Column(
                  children: <Widget>[
                    SizedBox(
                      height: 18.0,
                    ),
                    new Padding(
                      padding: EdgeInsets.only(left: 14.0, top: 10.0),
                      child: new Text('Notificaciones',
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.0)),
                    ),
                  ],
                )
              ],
            ),
          )),
    );

    final resultados = Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(16.0)),
          onPressed: () {
            Navigator.of(contexto).push(MaterialPageRoute(builder: (contexto) {
              return new ResultadoInicial(); //ResultadoInicial
            }));
          },
          padding: EdgeInsets.all(12),
          color: Colors.lightBlueAccent,
          child: new Container(
            height: 80.0,
            width: 220.0,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Center(
                      child: new Image.asset(
                        'assets/pie-chart.png',
                        height: 80.0,
                        width: 70.0,
                      ),
                    ),
                  ],
                ),
                new Column(
                  children: <Widget>[
                    SizedBox(
                      height: 18.0,
                    ),
                    new Padding(
                      padding: EdgeInsets.only(left: 14.0, top: 10.0),
                      child: new Text('  Resultados',
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.0)),
                    ),
                  ],
                )
              ],
            ),
          )),
    );

    return Scaffold(
      body: new Center(
        child: new Column(
          children: <Widget>[
            SizedBox(
              height: 98.0,
            ),
            calificarClientew,
            notificaciones,
            resultados
          ],
        ),
      ),
    );
  }

  Future<void> initOneSignal() async {
    OneSignal.shared.init("f990f412-702a-4d15-ac28-f6980de8de0a");
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.none);

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      print(" Notificación : ${notification.payload.body}");
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      var fecha, nombreAsesor, numerovisitas, idDocument;
      result.notification.payload.additionalData.forEach((String key, var val) {
        if (key == 'fecha') {
          fecha = val;
        } else if (key == 'nombreAsesor') {
          nombreAsesor = val;
        } else if (key == 'numeroVisitas') {
          numerovisitas = val;
        } else if (key == 'idDocumento') {
          idDocument = val;
        }
      });
      new Dialogs().showDialogRecibirNotificacion(fecha, nombreAsesor,
          numerovisitas, idDocument, "resultado", "mensaje", context);
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      if (changes.to.userId != null) {
        // guardar -> changes.to.userId
        LocalStorage storage = new LocalStorage('famitiendas');
        storage.setItem("playerID", changes.to.userId);
      }
    });
  }
}
