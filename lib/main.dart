import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/controllers/auth_api.dart';
import 'package:flutter_application_1/app/modules/home/views/notification_hendler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessagingHandler().initPushNotification();
  //await FirebaseMessagingHandler().initLocalNotification();
  // Create an instance of AuthAPI
  AuthAPI authAPI = AuthAPI();
/*Client client = Client();
client
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('6565d94d74ef38e2abf9')
    .setSelfSigned(status: true); // For self signed certificates, only */
  runApp(
    // Wrap your entire app with ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (context) => authAPI,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
      ),
    ),
  );
}
