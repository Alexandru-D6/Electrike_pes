import 'package:flutter/material.dart';

import '../constants.dart';
import '../widget/car_list_item.dart';
import '../widget/lateral_menu_widget.dart';


class GaragePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mPrimaryColor,
      appBar: buildAppBar(),
      drawer: NavigationDrawerWidget(),
      body: ListView.builder(
        itemCount: carList.length,
        itemBuilder: (context, index) => CarListItem(index),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: mPrimaryColor,
      elevation: 0,
      title: Text('Garage'),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add_circle_rounded,
            color: Colors.white,
          ),
          onPressed: () {}, //to-do: form de nuevo coche
        )
      ],
    );
  }
}
