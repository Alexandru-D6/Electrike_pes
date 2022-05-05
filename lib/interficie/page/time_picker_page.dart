import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';


class TimePickerPage extends StatefulWidget {
  @override
  _TimePickerPageState createState()
  {
    return _TimePickerPageState();
  }
}

class _TimePickerPageState extends State<TimePickerPage> {
  TimeOfDay selectedTime = TimeOfDay.now();

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("When do you want to receive notifications?"), //TODO:  translate


            SelectWeekDays(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              days: _days,
              onSelect: (values) {
                print(values);
              },
            ),

            SelectWeekDays(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              days: _days,
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
              onSelect: (values) {
                print(values);
              },
            ),

            SelectWeekDays(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              days: _days,
              boxDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  // 10% of the width, so there are ten blinds.
                  colors: [Color(0xFFE55CE4), Color(0xFFBB75FB)], // whitish to gray
                  tileMode: TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
              onSelect: (values) {
                print(values);
              },
            ),


            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: const Text("Choose Time"), //TODO: translate
            ),
            Text("${selectedTime.hour}:${selectedTime.minute}"),
          ],
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