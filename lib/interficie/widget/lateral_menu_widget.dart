import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/generated/l10n.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/drop_down_widget.dart';
import 'package:sign_button/sign_button.dart';

CtrlPresentation ctrlPresentation = CtrlPresentation();

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    String name = ctrlPresentation.getCurrentUsername(context);
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
                if(name == S.of(context).clickToLogin) {
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
                    text: S.of(context).map,
                    icon: Icons.map_outlined,
                    onClicked: () => ctrlPresentation.toMainPage(context),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: S.of(context).garage,
                    icon: Icons.garage,
                    onClicked: () {
                      ctrlPresentation.toGaragePage(context);
                    },
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: S.of(context).favourites,
                    icon: Icons.favorite_border,
                    onClicked: () => ctrlPresentation.toFavouritesPage(context),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: S.of(context).achievements,
                    icon: Icons.emoji_events,
                    onClicked: () => ctrlPresentation.toRewardsPage(context),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 10),
                  const MyStatefulWidget(),

                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: S.of(context).information,
                    icon: Icons.info,
                    onClicked: () => ctrlPresentation.toInfoAppPage(context),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: S.of(context).contactUs,
                    icon: Icons.phone,
                    onClicked: () => ctrlPresentation.mailto(),
                  ),

                  const SizedBox(height: 10),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 10),

                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: S.of(context).logout,
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
    required String email,
    required BuildContext context,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              if (name != S.of(context).clickToLogin) CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage!))
              else
                SignInButton.mini(
                  buttonType: ButtonType.googleDark,
                  buttonSize: ButtonSize.large,
                  onPressed: (){
                    ctrlPresentation.signInRoutine(context);
                  },
                ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      name,
                      style: const TextStyle(fontSize: 80, color: Colors.white), //letra real a 20 pero como tenemos autoSizeText... 80 para que rellene
                      textAlign: TextAlign.center,
                      maxLines: (name != S.of(context).clickToLogin ? 1: 2),
                    ),
                    Row(
                      children:<Widget>[
                        if(email != "")
                        const SizedBox(height: 10),
                        if(email != "")
                          Expanded(
                            child: AutoSizeText(
                              email,
                              style: const TextStyle(fontSize: 14, color: Colors.white),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                          )
                      ],
                    ),
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