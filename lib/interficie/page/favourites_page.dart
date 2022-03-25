import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/widget/appbar.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';

import '../constants.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: const NavigationDrawerWidget(),
    appBar: AppBar(
      title: Text("Favourites"),
      backgroundColor: mPrimaryColor,
    ),
  );
}