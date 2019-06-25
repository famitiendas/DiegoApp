import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/entities/notification_data.dart';
import 'package:localstorage/localstorage.dart';
import 'package:onesignal/onesignal.dart';

class NotificationManager {
  void handleSendNotification(String fecha, String nombreAsesor,
      int numeroVisitas, String playerID, String idDocumento) async { 
    var data = {
      "fecha": fecha,
      "nombreAsesor": nombreAsesor,
      "numeroVisitas": numeroVisitas,
      "idDocumento":idDocumento
    };

    var imgUrlString =
        "http://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";

    var notification = OSCreateNotification(
      additionalData: data,
      playerIds: [playerID],
      content: "El asesor $nombreAsesor ha tenido su visita número $numeroVisitas",
      heading: "Transferencia",
      bigPicture: imgUrlString,
    ); 

    LocalStorage storage = new LocalStorage('famitiendas');
    NotificationData notificationData = new NotificationData.toSave(
        DateTime.now().toString(), nombreAsesor, numeroVisitas);
    await Firestore.instance.collection('usuarios').getDocuments().then((docs) {
      docs.documents.forEach((doc) {
        if (doc.data['usuario'] == storage.getItem("user")) {
          saveNotifications(notificationData, doc.documentID);
        }
      });
    });

    var response = await OneSignal.shared.postNotification(notification);

    print("Sent notification with response: $response");
  }

  void saveNotifications(
      NotificationData notification, String documento) async {
    await Firestore.instance
        .collection('usuarios')
        .document(documento)
        .collection('Notificaciones')
        .document()
        .setData(notification.toJson())
        .then((notif) {
      print('saved succesfully');
    }).then((error) => print(error));
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
