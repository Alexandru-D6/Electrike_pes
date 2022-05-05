import 'package:auto_size_text/auto_size_text.dart';
import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';


class TimePickerPage extends StatefulWidget {
  @override
  _TimePickerPageState createState()
  {
    return _TimePickerPageState();
  }
}

class _TimePickerPageState extends State<TimePickerPage> {
  TimeOfDay selectedTime = TimeOfDay.now();
  List<String> selectedDays = <String>[];

  //todo: translate
  final List<DayInWeek> _days = [
    DayInWeek(
      "Lunes",
    ),
    DayInWeek(
      "Martes",
    ),
    DayInWeek(
      "Miercoles",
    ),
    DayInWeek(
      "Jueves",
    ),
    DayInWeek(
      "Viernes",
    ),
    DayInWeek("SÃ¡bado"),
    DayInWeek("Domingo"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications settings"), //TODO:  translate
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const AutoSizeText("When do you want to receive notifications?", style: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),), //TODO:  translate

              const Divider(height: 20,),

              SelectWeekDays(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                days: _days,
                onSelect: (values) {
                  selectedDays = values;
                  print(values);
                },

                /*other types of decorations
                border: false,
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    // 10% of the width, so there are ten blinds.
                    colors: [Color(0xFFE55CE4), Color(0xFFBB75FB)], // whitish to gray
                    tileMode: TileMode.repeated, // repeats the gradient over the canvas
                  ),
                ),

                **************************************************************************************
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    // 10% of the width, so there are ten blinds.
                    colors: [Color(0xFFE55CE4), Color(0xFFBB75FB)], // whitish to gray
                    tileMode: TileMode.repeated, // repeats the gradient over the canvas
                  ),
                ),

                 */

              ),

              const Divider(height: 30,),

              ElevatedButton.icon(
                icon: const Icon(
                  Icons.schedule,
                  color: Colors.white,
                  size: 24.0,
                ),
                onPressed: () {
                  _selectTime(context);
                },
                label: const Text("Choose Time"), //TODO: translate
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const Divider(height: 20,),
              AutoSizeText("${selectedTime.hour}:${selectedTime.minute}", style: const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),),
              FloatingActionButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("You will be notified "+selectedDays.toString()+" at "+"${selectedTime.hour}:${selectedTime.minute}")),
                  );
                },
                heroTag: "Add notification",//todo:translate
                tooltip: "Add notification",//todo:translate
                child: const Icon(Icons.more_time),
                backgroundColor: mPrimaryColor,
              ),
            ],
          ),
        ),
      ),

    );
  }
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}