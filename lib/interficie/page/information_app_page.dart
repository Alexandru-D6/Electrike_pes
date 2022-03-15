import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';

class InformationAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: NavigationDrawerWidget(), //esto es para que aparezca el botón de menú lateral
    appBar: AppBar(
      title: Text('About the App'),
      centerTitle: true,
      backgroundColor: Colors.red,
    ),
  );
}