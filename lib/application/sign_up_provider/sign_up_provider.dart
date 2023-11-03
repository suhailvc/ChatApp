import 'package:chat_app/domain/user_model/user_model.dart';
import 'package:chat_app/presentation/widgets/warning.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  signUpUser(context, String imagePath) async {
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        imagePath.isEmpty) {
      warning(context, 'Please fill in all the fields.');
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      warning(context, 'Please enter a valid email address.');
      return;
    }

    if (password.length < 6) {
      warning(context, 'Password must be at least 6 characters long.');
      return;
    }
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      warning(context, 'email already present');
      notifyListeners();
      return;
    }
    await _auth.authStateChanges().firstWhere((user) => user != null);
    notifyListeners();
    warning(context, 'Successfully signed up');
    nameController.clear();
    passwordController.clear();
    emailController.clear();
    notifyListeners();
    String uid = _auth.currentUser!.uid;
    UserDetails user = UserDetails(
      name: name,
      email: email,
      imgpath: imagePath,
      password: password,
      uid: uid,
    );
    Map<String, dynamic> userData = user.toJson();
    FirebaseFirestore.instance.collection('users').doc(uid).set(userData);
    notifyListeners();
    FirebaseFirestore.instance.collection('uids').add({
      'uid': FirebaseAuth.instance.currentUser!.uid.toString(),
    });
    FirebaseFirestore.instance
        .collection('chat_list')
        .doc(uid)
        .set({"Uid": []});
    false;
  }
}
