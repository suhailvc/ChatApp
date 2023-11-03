import 'package:chat_app/application/profile_data.provider/get_all_user_provider.dart';
import 'package:chat_app/presentation/screen/chat_screen/chat_screen.dart';
import 'package:chat_app/presentation/screen/search_screen.dart/widget/search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = Provider.of<GetallUsersProvider>(context).searchController;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ChangeNotifierProvider<GetallUsersProvider>.value(
                value: Provider.of<GetallUsersProvider>(context, listen: false),
                child: SearchField(controller: controller),
              ),
            ),
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
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(user.imgpath.toString()),
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
    );
  }
}
