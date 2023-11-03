import 'package:chat_app/application/profile_data.provider/get_all_user_provider.dart';
import 'package:chat_app/infrastructure/push_notification/push_notification.dart';
import 'package:chat_app/presentation/screen/chat_screen/chat_screen.dart';
import 'package:chat_app/presentation/screen/drawer_screen/drawer_screen.dart';
import 'package:chat_app/presentation/screen/home_screen/widget/floating_button.dart';
import 'package:chat_app/presentation/screen/home_screen/widget/pop_up.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    saveToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = Provider.of<GetallUsersProvider>(context).searchController;

    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text(
          "Chat App",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.teal,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: popUpMenuButton(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.01),
            SizedBox(
              height: size.height * 0.02,
            ),
            Expanded(
              child: Consumer<GetallUsersProvider>(
                builder: (context, value, child) {
                  return FutureBuilder<void>(
                    future: value.getAllUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error fetching data'));
                      } else {
                        final userList = controller.text.isEmpty
                            ? value.allusers
                            : value.searchedlist;

                        if (userList.isEmpty) {
                          return const Center(child: Text('No data available'));
                        }

                        return ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            height: size.height * 0.02,
                          ),
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            final user = userList[index];
                            String? imgPath =
                                NetworkImage(user.imgpath.toString())
                                    .toString();
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                        token: user.pushToken.toString(),
                                        fromId: user.uid.toString(),
                                        title: user.name!,
                                      ),
                                    ));
                              },
                              leading: imgPath != null
                                  ? CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          NetworkImage(user.imgpath.toString()),
                                    )
                                  : const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/585e4bf3cb11b227491c339a.png'),
                                    ),
                              title: Text(user.name!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingButton(),
    );
  }
}
