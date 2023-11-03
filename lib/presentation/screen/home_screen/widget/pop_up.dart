import 'package:chat_app/presentation/screen/login_screen/login_screen.dart';
import 'package:chat_app/presentation/widgets/warning.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

PopupMenuButton<int> popUpMenuButton(BuildContext context) {
  return PopupMenuButton(
    child: const Icon(FontAwesomeIcons.ellipsisVertical),
    onSelected: (value) async {
      if (value == 1) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete'),
            content: const Text('Do you want to LogOut?'),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('LOGOUT'),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    warning(context, e.toString());
                  }
                },
              ),
            ],
          ),
        );
      }
    },
    itemBuilder: (context) => [
      const PopupMenuItem(
        value: 1,
        child: Text(
          'LogOut',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}
