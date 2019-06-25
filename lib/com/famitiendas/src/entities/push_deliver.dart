import 'package:onesignal/onesignal.dart';
class PushDeliver{

 void initOneSignal(){
    OneSignal.shared.init("f990f412-702a-4d15-ac28-f6980de8de0a");
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.none);


  OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
  print(" Notificación : ${notification.payload.body}");
});

OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
        result.notification.payload.additionalData
            .forEach((String key, var val) {
        print("key: "+key+ "val:"+val);
        });

      
    });
     OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);


         OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
   
      if (changes.to.userId != null) {
        // guardar -> changes.to.userId
        print("playerID"+changes.to.userId);
       
      }
    });

  }



}