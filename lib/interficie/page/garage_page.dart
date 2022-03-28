import 'package:flutter/material.dart';

import '../constants.dart';
import '../ctrl_presentation.dart';
import '../widget/car_list_item.dart';
import '../widget/lateral_menu_widget.dart';


class GaragePage extends StatelessWidget {
  const GaragePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    List<List<String>> userCarList = ctrlPresentation.getCarsList();
    return Scaffold(
      backgroundColor: mPrimaryColor,
      appBar: buildAppBar(context),
      body: ListView.builder(
        itemCount: userCarList.length,
        itemBuilder: (context, index) => CarListItem(userCarList[index]),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: mPrimaryColor,
      elevation: 0,
      title: const Text('Garage'), //TODO: translator
      actions: [
        IconButton(
          icon: const Icon(
            Icons.add_circle_rounded,
            color: Colors.white,
          ),
          onPressed: (){
            ctrlPresentation.toFormCar(context);
             },
        )
      ],
    );
  }
}
