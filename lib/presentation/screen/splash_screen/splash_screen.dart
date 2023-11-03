import 'package:chat_app/presentation/screen/home_screen/home_screen.dart';
import 'package:chat_app/presentation/screen/login_screen/login_screen.dart';
import 'package:chat_app/presentation/widgets/warning.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    wait(context);
    return Container(
      color: Colors.teal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Chat App',
            style: GoogleFonts.pacifico(
              fontSize: 30,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}

wait(context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  var connectivityResult = await Connectivity().checkConnectivity();
  await Future.delayed(const Duration(milliseconds: 3700));
  if (connectivityResult == ConnectivityResult.none) {
    warning(context, 'No Interner Connection');
  }
  auth.currentUser?.uid != null
      ? Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()))
      : Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
}
