// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';

import '../../domini/user.dart';
import '../constants.dart';
import '../widget/lateral_menu_widget.dart';
import '../widget/numbers_widget.dart';
import '../widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}
CtrlPresentation ctrlPresentation = CtrlPresentation();
class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    User user = User(imagePath: ctrlPresentation.photoUrl, name: ctrlPresentation.name, email: ctrlPresentation.email, about: "", isDarkMode: false);

    return  Builder(
        builder: (context) => Scaffold(
          drawer: const NavigationDrawerWidget(),
          appBar: AppBar(
            title: const Text("Profile"),
            backgroundColor: mPrimaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user.imagePath,
                  onClicked: () {  },
                ),
                const SizedBox(height: 24),
                buildName(user),
                const SizedBox(height: 24),
                const SizedBox(height: 24),
                const NumbersWidget(),
                const SizedBox(height: 48),
                buildAbout(user),
              ],
            ),
          ),
        ),
    );
  }

  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: const TextStyle(color: Colors.grey),
      )
    ],
  );



  Widget buildAbout(User user) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          user.about,
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}