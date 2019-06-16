import 'package:flutter/material.dart';

class CalificaCliente extends StatefulWidget {
  CalificaCliente({Key key}) : super(key: key);

  _CalificaClienteState createState() => _CalificaClienteState();
}

class _CalificaClienteState extends State<CalificaCliente> {
  final _formKey = GlobalKey<FormState>();
  bool loginEnabled;
  bool isVisible;
  int cantidad = 1;
  var preguntas = [
    {
      "Pregunta":
          "Pregunta 111111111111111111111111111111111111111111111111111111111111111111111111111111111111111",
      "valor": ""
    },
    {"Pregunta": "Pregunta 222222222222222222222", "valor": ""},
    {"Pregunta": "Pregunta 2323232323232323232323233", "valor": ""},
    {
      "Pregunta":
          "Pregunta 2323232333333333333333333333333333333333333333333333333333333334",
      "valor": ""
    },
    {
      "Pregunta":
          "Pregunta 333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333335",
      "valor": ""
    },
    {
      "Pregunta":
          "Pregunta 3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333336",
      "valor": ""
    },
    {
      "Pregunta":
          "Pregunta 73333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333",
      "valor": ""
    },
    {
      "Pregunta":
          "Pregunta 333333333333333333333333333333333333333333333333333333333333333333333333333333333322222222222222222222222222228",
      "valor": ""
    },
    {
      "Pregunta":
          "Pregunta 222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222229",
      "valor": ""
    },
    {
      "Pregunta":
          "Pregunta  99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999910",
      "valor": ""
    }
  ];
  var opciones = ["Si", "No"];

  BuildContext contexto;
  TextEditingController _phoneNumber = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    contexto = context;
    void loguearse() async {
      print('Hola mundo');
      Navigator.of(contexto)
          .pushReplacement(MaterialPageRoute(builder: (contexto) {
        return new CalificaCliente();
      }));
    }

    final number = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      enabled: loginEnabled != null ? loginEnabled : true,
      controller: _phoneNumber,
      decoration: InputDecoration(
        hintText: 'Nombre Cliente',
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
        decoration: InputDecoration(
          hintText: 'Código Cliente',
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
    final cumplimiento = "";
    final listadoOpciones = ListView.builder(
        itemCount: preguntas.length,
        shrinkWrap: preguntas.length > 0,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width*0.65,
                    child: Text(
                      "${index + 1}.   ${preguntas[index]["Pregunta"]}",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(width: 15,),
                  Container(
                     width: MediaQuery.of(context).size.width*0.15,
                      child: DropdownButton( 
                    hint: new Text(
                      "${preguntas[index]["valor"]}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    items: opciones
                        .map((String value) => new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                overflow: TextOverflow.fade,
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.start,
                              ),
                            ))
                        .toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        preguntas[index]["valor"]=newValue;
                        //value = newValue;
                        //bank = newValue;
                      });
                    },
                  )),
                ],
              ));
        });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(
              height: 98.0,
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
                  listadoOpciones,
                  SizedBox(height: 5),
                  loginButton
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
  }
}
