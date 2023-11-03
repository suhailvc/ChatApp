import 'package:chat_app/application/image_picker_provider/image_pick_provider.dart';
import 'package:chat_app/application/log_in_provider/log_in_provider.dart';
import 'package:chat_app/application/message_provider/message_provider.dart';
import 'package:chat_app/application/profile_data.provider/get_all_user_provider.dart';
import 'package:chat_app/application/profile_data.provider/get_profile_data_provider.dart';
import 'package:chat_app/application/sign_up_provider/sign_up_provider.dart';
import 'package:chat_app/core/constant.dart';
import 'package:chat_app/infrastructure/push_notification/push_notification.dart';
import 'package:chat_app/presentation/screen/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirbaseNotification().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignUpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImagePickProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LogInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetProfileDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MessageCreationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetallUsersProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
