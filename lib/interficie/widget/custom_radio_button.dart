import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';

class CustomRadio extends StatefulWidget {
  const CustomRadio({Key? key}) : super(key: key);
  @override
  State<CustomRadio> createState() => _CustomRadioState();
}
/// This is the private State class that goes with MyStatefulWidget.
class _CustomRadioState extends State<CustomRadio> {

  Widget CustomRadioButton(String text, int index) {
    return OutlineButton(
      onPressed: () {
        setState(() {
          ctrlPresentation.routeType = index;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (ctrlPresentation.routeType == index) ? Colors.yellowAccent : Colors.black,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      borderSide:
      BorderSide(color: (ctrlPresentation.routeType == index) ? Colors.yellowAccent : Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomRadioButton("Normal", 0),
        const SizedBox(width: 5),
        CustomRadioButton("Charger Points", 1),
        const SizedBox(width: 5),
        CustomRadioButton("Eco", 2)
      ],
    );
  }
}