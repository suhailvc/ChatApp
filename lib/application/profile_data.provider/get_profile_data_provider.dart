import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../domain/user_model/user_model.dart';

class GetProfileDataProvider extends ChangeNotifier {
  Future<UserDetails?> getUserData(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        return UserDetails.fromJson(userData);
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
