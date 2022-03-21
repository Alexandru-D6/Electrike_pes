import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/drop_down_widget.dart';

//import '../../domini/traductor.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  //LanguagesEnum get selectedLanguage => userLanguage; //TODO: getUserLang

  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    const name = 'Víctor';
    const email = 'victorasenj@gmail.com';
    const urlImage =
        'https://avatars.githubusercontent.com/u/75260498?v=4&auto=format&fit=crop&w=634&q=80';

    return Drawer(
      child: Material(
        color: mPrimaryColor,
        //definim el color de fons del menú lateral
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => ctrlPresentation.selectedItem(context, 22),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Map',
                    icon: Icons.map_outlined,
                    onClicked: () => ctrlPresentation.selectedItem(context, 0),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Garage',
                    icon: Icons.garage,
                    onClicked: () => ctrlPresentation.selectedItem(context, 1),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Favourites',
                    icon: Icons.favorite_border,
                    onClicked: () => ctrlPresentation.selectedItem(context, 2),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Achievements',
                    icon: Icons.emoji_events,
                    onClicked: () => ctrlPresentation.selectedItem(context, 3),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 10),
                  const MyStatefulWidget(),

                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Information',
                    icon: Icons.info,
                    onClicked: () => ctrlPresentation.selectedItem(context, 4),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Contact us',//Translator().translate(selectedLanguage, 'Contact us'),
                    icon: Icons.phone,
                    onClicked: () => ctrlPresentation.selectedItem(context, 5),
                  ),

                  const SizedBox(height: 10),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 10),

                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onClicked: () => ctrlPresentation.selectedItem(context, 5), //TODO: reference logout routine
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
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )
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