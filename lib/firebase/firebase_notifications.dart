import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/utility/constant_logic_validation.dart';
class FirebaseNotifications{
  //create instance of FBM
  final _firebaseMessaging = FirebaseMessaging.instance;
  //init notifications for this app or device
Future<void>initNotifications()async{
await _firebaseMessaging.requestPermission();
String? fcmToken = await _firebaseMessaging.getToken();
}
//handle notification when received
// void handleMessage(RemoteMessage? message){
// if(message==null){return;}
// globalNavigatorKey.currentState!.pushNamed(AppRoutes.applicantProfile);
// }
// //handle notifications in case the app is terminated
// Future handleBackgroundNotifications()async{
//   FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
// }
}