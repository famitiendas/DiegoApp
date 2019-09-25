import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/entities/notification_data.dart';
import 'package:localstorage/localstorage.dart';
import 'package:onesignal/onesignal.dart';

class NotificationManager {
  void handleSendNotification(String fecha, String nombreAsesor,
      int numeroVisitas, var playerID, String idDocumento) async {
    var data = {
      "fecha": fecha,
      "nombreAsesor": nombreAsesor,
      "numeroVisitas": numeroVisitas,
      "idDocumento": idDocumento
    };

    var imgUrlString =
        "http://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";
    for (int i = 0; i < playerID.length; i++) {
      var notification = OSCreateNotification(
        additionalData: data,
        playerIds: [playerID[i]],
        content:
            "El asesor $nombreAsesor ha tenido su visita número $numeroVisitas",
        heading: "Transferencia",
        bigPicture: imgUrlString,
      ); 
      await OneSignal.shared.postNotification(notification);
      print("no se ha estallado esta monda");
    }
  }

  Future<String> getTokenUser(int telefono) async {
    String userID;
    await Firestore.instance
        .collection('users')
        .document(telefono.toString())
        .get()
        .then((doc) {
      if (doc.data != null) {
        userID = doc.data['userID'];
      } else {
        print('null');
      }
    });
    return userID;
  }
}
