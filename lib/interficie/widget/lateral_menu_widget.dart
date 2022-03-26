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
    String name = ctrlPresentation.getCurrentUsername();
    String email = ctrlPresentation.getCurrentUserMail();
    String urlImage = ctrlPresentation.getUserImage();

    return Drawer(
      child: Material(
        color: mPrimaryColor,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              context: context,
              onClicked: () {
                if(name == "Click to log-in") {
                  ctrlPresentation.signInRoutine(context);
                } else {
                  ctrlPresentation.toProfilePage(context);
                }
              },
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
                    onClicked: () {
                      ctrlPresentation.logoutRoutine(context);
                    },
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
    String? urlImage,
    required String name,
    String? email,
    required BuildContext context,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              if (name != "Click to log-in") CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage!))
              else
                SignInButton.mini(
                  buttonType: ButtonType.googleDark,
                  onPressed: (){
                    ctrlPresentation.signInRoutine(context);  //TODO: SIGNUP SETTER
                  },
                ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      email!,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                  ],
              ),
              ), //const Spacer(),
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