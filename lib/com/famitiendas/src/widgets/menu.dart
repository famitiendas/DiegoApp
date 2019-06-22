import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/notificaciones.dart';
import 'package:flutter/material.dart';
import 'CalificarCliente.dart';
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
  BuildContext contexto ;
    String _debugLabelString = "";
  String _externalUserId;
  bool _enableConsentButton = false;
  bool _requireConsent = true;
  @override
  Widget build(BuildContext context) {
    contexto = context;
    void rediretClient() async {
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
            // loguearse();
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
              Navigator.of(contexto).pushReplacement(
                            MaterialPageRoute(builder: (contexto) {
                          return new Notificaciones();
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
   Future<void> initPlatformState() async {
    print('one signal state');
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);

    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    OneSignal.shared.setNotificationReceivedHandler((notification) {
      this.setState(() {
        print(" Notificación : ${notification.payload.body}");
        _debugLabelString =
            "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
        print("look the aditional data recib: ${notification.hashCode}");
      });
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      this.setState(() {
        String originAccount;
        String moneyReceived;
        int hashcode;
        result.notification.payload.additionalData
            .forEach((String key, var val) {
          if (key == 'originAccount') {
            originAccount = val;
          } else if (key == 'moneySent') {
            moneyReceived = val;
          } else if (key == 'hashcode') {
            hashcode = val;
          }
        });
      //  checkNotifications(originAccount, moneyReceived, hashcode);
        _debugLabelString =
            "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      //   print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
      if (changes.to.userId != null) {
        //saveData(changes.to.userId);
        print("playerID"+changes.to.userId);
       // _storage.setItem('playerId', changes.to.userId);
      }
    });
    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges changes) {
      print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
    });

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared.init("f990f412-702a-4d15-ac28-f6980de8de0a");

    await OneSignal.shared
        .init("f990f412-702a-4d15-ac28-f6980de8de0a", iOSSettings: settings);

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();

    this.setState(() {
      _enableConsentButton = requiresConsent;
    });
  }
  
  
  }

}
