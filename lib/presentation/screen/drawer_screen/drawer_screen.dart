import 'package:chat_app/application/profile_data.provider/get_profile_data_provider.dart';
import 'package:chat_app/domain/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    var size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          FutureBuilder<UserDetails?>(
            future: GetProfileDataProvider().getUserData(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Center(child: Text('User not found'));
              }

              final UserDetails user = snapshot.data!;
              return Container(
                height: size.height * 0.4,
                decoration: const BoxDecoration(
                  color: Colors.teal,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NetworkImage(user.imgpath.toString()) != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  NetworkImage(user.imgpath.toString()),
                            )
                          : const CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage(
                                  'assets/images/585e4bf3cb11b227491c339a.png'),
                            ),
                      // CircleAvatar(
                      //   radius: 60.0,
                      //   backgroundImage: NetworkImage(user.imgpath.toString()),
                      // ),
                      SizedBox(height: size.height * 0.03),
                      Text(
                        user.name.toString(),
                        style: const TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: size.height * 0.03),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Welcome to our user-friendly chat app! Sign up, log in, and chat with ease. Connect and converse seamlessly - your new chat adventure begins here!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }
}
