import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/login_screen.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:onesignal/onesignal.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

final routes = <String , WidgetBuilder>{

LoginScreen.tag : (context) => LoginScreen(),
Menu.tag : (context) => Menu(),

};

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Famitiendas SC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes:  routes,
    );



  
}
}