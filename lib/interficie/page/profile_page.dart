import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/domini/user.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';
import 'package:flutter_project/interficie/widget/numbers_widget.dart';
import 'package:flutter_project/interficie/widget/profile_widget.dart';


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
          floatingActionButton: FloatingActionButton(
            backgroundColor: mCardColor,
            child: const Icon(Icons.delete_forever),
            onPressed: () {
              _showMyDialog();
            },
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

  _showMyDialog() {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Are you sure you want to delete your account?',
      desc: 'Deleting your account is permanent and will remove all content including cars, favourites points and profile settings.\nAre you sure you want to delete your account?\n',
      btnCancelOnPress: () {},
      btnOkIcon: (Icons.delete),
      btnOkText: "Delete",
      btnOkOnPress: () {
        ctrlPresentation.deleteAccount(context);
      },
      headerAnimationLoop: false,
    ).show();
  }
}