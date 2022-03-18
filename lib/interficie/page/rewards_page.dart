import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: const NavigationDrawerWidget(), //esto es para que aparezca el botón de menú lateral
    appBar: AppBar(
      title: const Text('Rewards'),
      centerTitle: true,
      backgroundColor: Colors.orange,
    ),
  );
}