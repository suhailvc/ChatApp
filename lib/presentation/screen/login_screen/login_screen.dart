import 'package:chat_app/application/log_in_provider/log_in_provider.dart';
import 'package:chat_app/presentation/screen/sign_up_screen/sign_up_screen.dart';
import 'package:chat_app/presentation/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.2),
              Text(
                'Chat App',
                style: GoogleFonts.pacifico(fontSize: 30),
              ),
              SizedBox(height: size.height * 0.02),
              const Text(
                'Log in our account',
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 78, 69, 206)),
              ),
              SizedBox(height: size.height * 0.06),
              CustomTextField(
                dataController: context.read<LogInProvider>().emailController,
                secure: false,
                icon: const Icon(Icons.email),
                hintText: 'Email',
              ),
              SizedBox(height: size.height * 0.03),
              CustomTextField(
                dataController:
                    context.read<LogInProvider>().passwordController,
                secure: true,
                icon: const Icon(Icons.lock),
                hintText: 'Password',
              ),
              SizedBox(height: size.height * 0.03),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(221, 78, 69, 206),
                      minimumSize: const Size(100, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () {
                    Provider.of<LogInProvider>(context, listen: false)
                        .loginUser(context);
                  },
                  child: const Text('Log In')),
              SizedBox(height: size.height * 0.03),
              SizedBox(height: size.height * 0.02),
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: "Don't have account? Lets  ",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  TextSpan(
                    text: 'Sign Up',
                    style: const TextStyle(
                        color: Color.fromARGB(221, 78, 69, 206), fontSize: 15),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ));
                      },
                  )
                ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}
