import 'package:auto_size_text/auto_size_text.dart';
import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/widget/edit_car_arguments.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
    DayInWeek("Sabado"),
    DayInWeek("Domingo"),
  ];

  @override
  Widget build(BuildContext context) {
    final notificationsInfo = ModalRoute.of(context)!.settings.arguments as NewNotificationArgs;
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context).notificationSettings), //TODO (Peilin) ready for test
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 AutoSizeText(AppLocalizations.of(context).receiveNoti,
                  style: const TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  maxLines: 2,
                ), //TODO (Peilin) ready for test

                const Divider(height: 20,),

                SelectWeekDays(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  days: _days,
                  onSelect: (values) {
                    selectedDays = values;
                    print(values);
                  },
                  boxDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      // 10% of the width, so there are ten blinds.
                      colors: [Color(0xFF40ac9c), Color(0xFF203e5a)], // whitish to gray
                      tileMode: TileMode.repeated, // repeats the gradient over the canvas
                    ),
                  ),

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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.schedule,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      onPressed: () {
                        _selectTime(context);
                      },
                      label: Text(AppLocalizations.of(context).time), //TODO (Peilin) ready for test
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    const Spacer(),
                    AutoSizeText("${selectedTime.hour}:${selectedTime.minute}", style: const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),),
                  ],
                ),
              ],
            ),
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).notificationInfoMsg(selectedDays.toString(), selectedTime.hour.toString(), selectedTime.minute.toString()))), // TODO (Peilin) ready for test
          );
        },
        heroTag: AppLocalizations.of(context).addNoti,//TODO (Peilin) ready for test
        tooltip: AppLocalizations.of(context).addNoti,//TODO (Peilin) ready for test
        child: const Icon(Icons.more_time),
        backgroundColor: mPrimaryColor,
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