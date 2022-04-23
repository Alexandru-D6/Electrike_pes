import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';
//import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/ocupation_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;


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
                width: 500.0,
                height: 500.0,
                child: OcupationChart(createData(), animate: false),
              )
          )
        ]
      )
    );
  }
  static List<charts.Series<OrdinalSales, String>> createData() {
    //todo por aqui recibir la variable data que se vaya actualizando, hay que hablar de como hacerlo, mi idea es que vaya cambiando esta variable y el usuario para ver los cambios tenga que cargar un grafico nuevo, y nos dejamos de statefuls
    final data = [
      OrdinalSales('2014', 5),
      OrdinalSales('2015', 25),
      OrdinalSales('2016', 100),
      OrdinalSales('2017', 75),
    ];

    return [
      charts.Series<OrdinalSales, String>(
          id: 'Sales',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (OrdinalSales sales, _) =>
          '\$${sales.sales.toString()}')
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
