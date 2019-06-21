import 'package:flutter/material.dart';

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
}
