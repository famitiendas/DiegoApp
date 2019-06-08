import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/menu.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
   static String tag = 'LoginScreen';

  static Route<dynamic> route(){
return MaterialPageRoute(
builder: (context)=> LoginScreen(),
);

  }

  LoginScreen({Key key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   bool loginEnabled;
  bool isVisible;
    BuildContext contexto;
   TextEditingController _phoneNumber = new TextEditingController();
  TextEditingController _passw = new TextEditingController();
final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
        contexto = context;
        final number = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      enabled: loginEnabled != null ? loginEnabled : true,
      controller: _phoneNumber,
      decoration: InputDecoration(
        hintText: 'ingrese usuario',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = Visibility(
    //  visible: isVisible != null ? isVisible : true,
      child: TextFormField(
        autofocus: false,
        obscureText: true,
    //    controller: _passw,
        validator: (value) {
          if (value.isEmpty) {
            return 'ingrese Contraseña';
          }
        },
        decoration: InputDecoration(
          hintText: 'Contraseña',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
       loguearse();
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Entrar', style: TextStyle(color: Colors.white)),
      ),
    );
     final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );
    final firstRow = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        loginButton,
        SizedBox(height: 28.0,),
        Image.asset('assets/logo.png'),
      ],
    );

 
    return Scaffold(
      backgroundColor: Colors.white,
       body:Form(
           key: _formKey,
           
           child: ListView(
             shrinkWrap: true,
             padding: EdgeInsets.only(left: 24.0,right: 24.0),
             children: <Widget>[
               SizedBox(height: 50.0,),
               Image.asset('assets/logo.png'),
               SizedBox(height: 98.0,),
               new Center(
                 child: new Column(
                    children: <Widget>[
                number,
               SizedBox(height: 18.0),
               password,
                SizedBox(height: 18.0,),
                loginButton
                    ],
                 ),
               ),
              
                SizedBox(height: 98.0,),
              Image.asset('assets/logo.png')

             ],
           ),
         
       ),
    );
  }

   void loguearse()async{

    print('Hola mundo');
    Navigator.of(contexto)
        .pushReplacement(MaterialPageRoute(builder: (contexto) {
      return new Menu();
    }));

 } 
}