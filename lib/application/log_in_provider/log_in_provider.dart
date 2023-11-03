import 'package:chat_app/presentation/screen/home_screen/home_screen.dart';
import 'package:chat_app/presentation/widgets/warning.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  loginUser(context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      warning(context, 'Please fill in all the fields.');
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      warning(context, 'Please enter a valid email address.');
      return;
    }

    if (password.length < 6 || password.isEmpty) {
      warning(context, 'Password must be at least 6 characters long.');
      return;
    }
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emailController.clear();
      passwordController.clear();
      notifyListeners();
      if (userCredential.user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false);
      }
    } catch (error) {
      warning(context, 'Invalid email or password. Please try again.');
    }
  }
}
