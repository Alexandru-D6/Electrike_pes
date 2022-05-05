import 'package:flutter/material.dart';
import 'package:flutter_project/domini/data_graphic.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
//import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/ocupation_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_maps/google_maps.dart';


class ChartPage extends StatelessWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pointTitle = ModalRoute.of(context)!.settings.arguments as String;
    //CtrlPresentation ctrlPresentation = CtrlPresentation();
    return Scaffold(
      backgroundColor: mPrimaryColor,
      appBar: buildAppBar(context),
      body:
      Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child:
              RichText(
                text: TextSpan(
                  text: pointTitle,
                  style: const TextStyle(color: Colors.white, fontSize: 25),


              )
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            alignment: Alignment.bottomCenter,
            child:
              SizedBox(
                width: 800.0,
                height: 500.0,
                child: OcupationChart(createData(), animate: false),
              )
          )
        ]
      )
    );
  }
  static List<charts.Series<DataGraphic, String>> createData() {
    //todo por aqui recibir la variable data que se vaya actualizando, hay que hablar de como hacerlo, mi idea es que vaya cambiando esta variable y el usuario para ver los cambios tenga que cargar un grafico nuevo, y nos dejamos de statefuls
    final data = ctrlPresentation.getInfoGraphic("Thursday");

    return [
      charts.Series<DataGraphic, String>(
          id: 'Ocupacio',
          domainFn: (DataGraphic occupation, _) => occupation.hour.toString(),
          measureFn: (DataGraphic occupation, _) => occupation.percentage.round(),
          data: data,
          // Set a label accessor to control the text of the bar label.

          labelAccessorFn: (DataGraphic occupation, _) =>
          '${occupation.percentage.toString()}%')
    ];
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: mPrimaryColor,
      elevation: 0,
      title: const Text('Charts'),
    );
  }
}
