import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vita_app/firebase/database.dart';
import 'package:vita_app/models/user_model.dart';
import 'package:vita_app/pages/settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('My Account'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.to(() => const SettingsPage()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<UserModel>(
          stream: DatabaseService().currentUserData,
          builder: (context, snapshot) {
            UserModel? user = snapshot.data;
            return Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green[200],
                      radius: 30,
                      child: const Icon(
                        Icons.person,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(
                            snapshot.hasData ? user!.name! : 'Loading...',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 4,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(
                            snapshot.hasData ? user!.email! : '',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomContainer(
                      text: 'Completed Tasks',
                      num: snapshot.hasData ? user!.completedTask! : 0,
                    ),
                    CustomContainer(
                      text: 'Pending Tasks',
                      num: snapshot.hasData ? user!.pendingTask! : 0,
                    ),
                  ],
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    // GoogleSignIn gSignIn = GoogleSignIn();
                    // gSignIn.disconnect();
                    await FirebaseAuth.instance.signOut();
                  },
                  child: const Text(
                    'Log Out',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.text,
    required this.num,
  });

  final String text;
  final int num;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 140,
      decoration: BoxDecoration(
        color: Colors.green[200], 
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            '$num',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
