import 'package:flutter/material.dart';

import '../constants.dart';
import '../widget/car_list_item.dart';
import '../widget/lateral_menu_widget.dart';


class GaragePage extends StatelessWidget {
  const GaragePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mPrimaryColor,
      appBar: buildAppBar(),
      drawer: const NavigationDrawerWidget(),
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
      title: const Text('Garage'),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.add_circle_rounded,
            color: Colors.white,
          ),
          onPressed: () {}, //TODO: form de nuevo coche
        )
      ],
    );
  }
}
