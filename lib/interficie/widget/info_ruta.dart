import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/interficie/widget/google_map.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project/interficie/widget/custom_radio_button.dart';

class InfoRuta extends StatefulWidget {
  const InfoRuta({
    Key? key,
  }) : super(key: key);

  @override
  State<InfoRuta> createState() => _InfoRutaState();
}
class _InfoRutaState extends State<InfoRuta> {
  String time = "";
  String distance = "";

  @override
  void initState() {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    ctrlPresentation.getDistDuration().then((value) {
      setState(() {
        distance = value[0];
        time = value[1];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final controller = ScrollController();
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    CtrlDomain ctrlDomain = CtrlDomain();

    List<List<String>> userCarList = ctrlPresentation.getCarsList();
    print(userCarList.length);
    if (userCarList.isNotEmpty) {
      ctrlPresentation.idCarUser = 1;
      ctrlDomain.selectVehicleUsuari(ctrlPresentation.idCarUser);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: mPrimaryColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: <Widget>[
          Text(AppLocalizations.of(context).selectCar),
          (ctrlPresentation.getCurrentUserMail() != "" && ctrlPresentation.getCarsList().isNotEmpty ) ? SizedBox(
            height: 100,
            width: 100,
            child: NotificationListener<ScrollEndNotification>(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },), child: ListView.builder(
                shrinkWrap: true,
                itemCount: userCarList.length,
                itemBuilder: (context, index) => carItem(userCarList[index]),

                controller: controller,
                physics: const PageScrollPhysics(),
                //To stop 1 at a time
                // This next line does the trick.
                scrollDirection: Axis.horizontal,

              ),),
              onNotification: (notification) {
                ctrlPresentation.idCarUser =
                    (controller.position.pixels) ~/ 100 +
                        1; //dividir el numero de pixeles por el espacio que ocupen los containers. 200 ahora mismo.
                ctrlDomain.selectVehicleUsuari(ctrlPresentation.idCarUser);
                print(controller.position.pixels);
                print(ctrlPresentation.idCarUser);
                // Return true to cancel the notification bubbling. Return false (or null) to
                // allow the notification to continue to be dispatched to further ancestors.
                return true;
              },
            ),

          ) : SizedBox(
            height: 100,
            width: 100,
            child: Image.asset("assets/brandCars/rayo.png"),
          ),
          const Divider(
            height: 3,
            color: Color(0x00000000),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(AppLocalizations.of(context).actualBatMsg),
              Container(margin: const EdgeInsets.only(right: 10)),
              SizedBox(
                width: 40,
                child:
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: ctrlPresentation.bateria,
                  onChanged: (value) {
                    ctrlPresentation.bateria = value;
                    ctrlPresentation.getDistDuration().then((value) {
                      setState(() {
                        distance = value[0];
                        time = value[1];
                      });
                    });
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    CustomMaxValueInputFormatter(maxInputValue: 100)
                  ],

                ),
              ),
              const Text("%"),
            ],
          ),
          const Divider(
            height: 5,
            color: Color(0x00000000),
          ),
          Text(AppLocalizations.of(context).selectRouteType),
          const Divider(
            height: 16,
            color: Color(0x00000000),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              customRadioButton(AppLocalizations.of(context).standard, 0),
              const SizedBox(width: 5),
              customRadioButton(AppLocalizations.of(context).chargingStop, 1),
              const SizedBox(width: 5),
              customRadioButton("Eco", 2)
            ],
          ),
          const Divider(
            height: 16,
            color: Color(0x00000000),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(AppLocalizations.of(context).duration + ':'),
                Text(time),
              ]
          ),
          const Divider(
            height: 5,
            color: Color(0x00000000),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Text(AppLocalizations.of(context).distance + ':'),
                Text(distance),
              ]
          ),
          const Divider(
            height: 16,
            color: Color(0x00000000),
          ),
          ElevatedButton(
            onPressed: () {
              ctrlPresentation.makeRoute();
              ctrlPresentation.toMainPage(context);
              ctrlPresentation.increaseRouteCounter();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),),
              primary: const Color(0xff8A84E2),
            ),
            child: Text(AppLocalizations.of(context).start),
          ),
        ],
      ),
    );
  }

  Widget customRadioButton(String text, int index) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    return OutlinedButton(
      onPressed: () {
          setState(() {
            ctrlPresentation.routeType = index;
          });
          ctrlPresentation.getDistDuration().then((value) {
            setState(() {
              distance = value[0];
              time = value[1];
            });
          });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (ctrlPresentation.routeType == index) ? Colors.yellowAccent : Colors.black,
        ),
      ),
    );
  }

  Widget carItem(List<String> car) {
    String carImage = "assets/brandCars/" + car[2].toLowerCase() + ".png";
    if (allCarsPathsImages.contains(carImage)) {
      carImage = "assets/brandCars/" + car[2].toLowerCase() + ".png";
    } else {
      carImage = "assets/brandCars/defaultBMW.png";
    }
    return Container(
      width: 100.0,
      decoration: BoxDecoration(
        //shape: BoxShape.rectangle,
        border: Border.all(width: 6.0, color: const Color(0xff353535)),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: const Color(0xffafafdc),
        image: DecorationImage(
          scale: 3,
          image: AssetImage(carImage),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(car[1]),
      ),

    );
  }
}

//Para poner un limite de bateria al 100% si se pasa se cambia a 100.
class CustomMaxValueInputFormatter extends TextInputFormatter {
  final double maxInputValue;

  CustomMaxValueInputFormatter({required this.maxInputValue});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue){
    final TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

      final double? value = double.tryParse(newValue.text);
      if(value == null){
        return TextEditingValue(
          text: truncated,
          selection: newSelection,
        );
      }
      if(value > maxInputValue){
        truncated = maxInputValue.toString();
      }
    return TextEditingValue(
      text: truncated,
      selection: newSelection,
    );
  }
}