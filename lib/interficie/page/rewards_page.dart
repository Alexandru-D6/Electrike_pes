import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';

class RewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: NavigationDrawerWidget(), //esto es para que aparezca el botón de menú lateral
    appBar: AppBar(
      title: Text('Rewards'),
      centerTitle: true,
      backgroundColor: Colors.orange,
    ),
  );
}