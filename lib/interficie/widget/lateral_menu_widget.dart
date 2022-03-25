// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/drop_down_widget.dart';
import 'package:sign_button/sign_button.dart';

//import '../../domini/traductor.dart';
CtrlPresentation ctrlPresentation = CtrlPresentation();

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  //LanguagesEnum get selectedLanguage => userLanguage; //TODO: getUserLang

  @override
  Widget build(BuildContext context) {
    String? name = ctrlPresentation.getCurrentUsername();
    String? email = ctrlPresentation.getCurrentUserMail();
    const urlImage =
        'https://avatars.githubusercontent.com/u/75260498?v=4&auto=format&fit=crop&w=5&q=80'; //TODO: qué me pasa domain para la foto??

    return Drawer(
      child: Material(
        color: mPrimaryColor,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => ctrlPresentation.toProfilePage(context),//ctrlPresentation.toLoginPage(context),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Map', //TODO: translator
                    icon: Icons.map_outlined,
                    onClicked: () => ctrlPresentation.toMainPage(context),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Garage', //TODO: translator
                    icon: Icons.garage,
                    onClicked: () => ctrlPresentation.toGaragePage(context),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Favourites', //TODO: translator
                    icon: Icons.favorite_border,
                    onClicked: () => ctrlPresentation.toFavouritesPage(context),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Achievements', //TODO: translator
                    icon: Icons.emoji_events,
                    onClicked: () => ctrlPresentation.toRewardsPage(context),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 10),
                  const MyStatefulWidget(),

                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Information', //TODO: translator
                    icon: Icons.info,
                    onClicked: () => ctrlPresentation.toInfoAppPage(context),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Contact us',//Translator().translate(selectedLanguage, 'Contact us'),
                    icon: Icons.phone,
                    onClicked: () => ctrlPresentation.mailto(),
                  ),

                  const SizedBox(height: 10),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 10),

                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Logout', //TODO: translator
                    icon: Icons.logout,
                    onClicked: () => (){},//ctrlPresentation.logout(), //TODO: reference logout routine
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    String? name,
    String? email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              if (name != null) CircleAvatar(radius: 5, backgroundImage: NetworkImage(urlImage))
              else
                SignInButton.mini(
                  buttonType: ButtonType.googleDark,
                  onPressed: (){
                    //ctrlPresentation.signInRoutine();  TODO: SIGNUP SETTER
                  },
                ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? "Click to login",
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email ?? "",
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              //const Spacer(),
            ],
          ),
        ),
      );
}

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(fontSize: 18, color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }