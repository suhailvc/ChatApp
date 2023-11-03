import 'dart:io';
import 'package:chat_app/application/image_picker_provider/image_pick_provider.dart';
import 'package:chat_app/application/sign_up_provider/sign_up_provider.dart';
import 'package:chat_app/presentation/screen/login_screen/login_screen.dart';
import 'package:chat_app/presentation/screen/sign_up_screen/widget/sign_up_button.dart';
import 'package:chat_app/presentation/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Provider.of<ImagePickProvider>(context, listen: false).clearImage();
          },
          child: const Icon(
            Icons.arrow_back,
            size: 32,
            color: Color.fromARGB(255, 78, 69, 206),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up for Social Light',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Consumer<ImagePickProvider>(
                builder: (context, value, child) {
                  //   String? imgPath = value.imagePath;
                  return Container(
                    width: size.width * 0.3,
                    height: size.height * 0.15,
                    decoration: BoxDecoration(
                      border: Border.all(width: 5, color: Colors.blue),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () => value.getImage(ImageSource.gallery),
                        child: value.imagePath != null
                            ? ClipOval(
                                child: Container(
                                  width: size.width * 0.4,
                                  height: size.height * 0.15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                          File(value.imagePath!),
                                        )),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                            : ClipOval(
                                child: Container(
                                  width: size.width * 0.3,
                                  height: size.height * 0.15,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      FontAwesomeIcons.userTie,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  );
                },
              ),
              Column(
                children: [
                  SizedBox(height: size.height * 0.03),
                  CustomTextField(
                    dataController:
                        Provider.of<SignUpProvider>(context).nameController,
                    secure: false,
                    icon: const Icon(Icons.person),
                    hintText: 'name',
                  ),
                  SizedBox(height: size.height * 0.02),
                  CustomTextField(
                    dataController:
                        Provider.of<SignUpProvider>(context).emailController,
                    secure: false,
                    icon: const Icon(Icons.email),
                    hintText: 'email',
                  ),
                  SizedBox(height: size.height * 0.02),
                  CustomTextField(
                    dataController:
                        Provider.of<SignUpProvider>(context).passwordController,
                    secure: true,
                    icon: const Icon(Icons.lock),
                    hintText: 'Password',
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              const SignUpButton(),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false);
                        },
                      text: ' Log in',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 78, 69, 206),
                        fontSize: 15,
                      ),
                    )
                  ])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
