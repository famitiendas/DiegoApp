import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/notificaciones.dart';
import 'package:flutter/material.dart';
import 'CalificarCliente.dart';

class Menu extends StatefulWidget {
  static String tag = 'Menu';

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Menu(),
    );
  }

  Menu({Key key}) : super(key: key);

  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  BuildContext contexto ;
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
  }
}
