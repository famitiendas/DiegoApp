import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famitiendas_distribuciones/com/famitiendas/src/widgets/Dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:onesignal/onesignal.dart';

class PushDeliver {
  void initOneSignal() {
    OneSignal.shared.init("f990f412-702a-4d15-ac28-f6980de8de0a");
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.none);

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      print(" Notificación : ${notification.payload.body}");
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
          var fecha,nombreAsesor,numerovisitas,idDocument;
      result.notification.payload.additionalData.forEach((String key, var val) {
      if (key == 'originAccount') {
            fecha = val;
          } else if (key == 'moneySent') {
            nombreAsesor = val;
          } else if (key == 'hashcode') {
            numerovisitas = val;
          } else if (key == 'hashcode') {
            idDocument = val;
          }
        checkNotifications(fecha,nombreAsesor,numerovisitas,idDocument);
        print("key: " + key + "val:" + val);
      });
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      if (changes.to.userId != null) {
        // guardar -> changes.to.userId
        LocalStorage storage = new LocalStorage('famitiendas');
        storage.setItem("playerID", changes.to.userId);
        print("playerID" + changes.to.userId);
      }
    });
  }

  void checkNotifications(String fecha,String nombreAsesor,int numerovisitas,String idDocument) async {
    await Firestore.instance
        .collection('users')
        .getDocuments()
        .then((docs) {
      docs.documents.forEach((doc) {
        if (doc.data['hashcode'] == nombreAsesor) {}
      });
    });
  }
}
