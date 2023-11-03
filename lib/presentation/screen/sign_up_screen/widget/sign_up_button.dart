import 'dart:async';

import 'package:chat_app/application/image_picker_provider/image_pick_provider.dart';
import 'package:chat_app/application/sign_up_provider/sign_up_provider.dart';
import 'package:chat_app/presentation/widgets/warning.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (Provider.of<ImagePickProvider>(context, listen: false).imageUrl ==
            null) {
          return warning(context, "Photo is empty");
        }
        await Provider.of<SignUpProvider>(context, listen: false).signUpUser(
            context,
            Provider.of<ImagePickProvider>(context, listen: false).imageUrl!);
        Timer(
          const Duration(seconds: 3),
          () {
            Provider.of<ImagePickProvider>(context, listen: false).clearImage();
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 78, 69, 206),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Provider.of<SignUpProvider>(context).isLoading
          ? const CircularProgressIndicator()
          : const Text(
              'Sign Up',
              style: TextStyle(fontSize: 16),
            ),
    );
  }
}
