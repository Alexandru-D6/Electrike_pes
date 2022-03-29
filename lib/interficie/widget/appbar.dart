import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';

import 'lateral_menu_widget.dart';


Scaffold buildAppBar(BuildContext context, {required String title}) {
  return Scaffold(
    drawer: const NavigationDrawerWidget(),
    appBar: AppBar(
      title: Text(title),
      backgroundColor: mPrimaryColor,
    ),
  );
}