import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';


class DayOfWeekPickerWidget extends StatefulWidget {

  @override
  State<DayOfWeekPickerWidget> createState() => _DayOfWeekPickerWidgetState();
}
  class _DayOfWeekPickerWidgetState extends State<DayOfWeekPickerWidget> {
    String dropdownValue = 'Monday';
  @override
  Widget build(BuildContext context) {
    const color = Colors.white;

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',]
        .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
        }).toList(),
    );
  }
}
