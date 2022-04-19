import 'package:flutter/material.dart';
import 'package:flutter_project/generated/l10n.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/ocupation_chart.dart';



class ChartPage extends StatelessWidget {
  const ChartPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
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
                text: const TextSpan(
                  text: 'JUAN',
                  style: TextStyle(color: Colors.white, fontSize: 25),


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
                child: OcupationChart.withSampleData(),
              )
          )
        ]
      )
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: mPrimaryColor,
      elevation: 0,
      title: Text(S.of(context).charts),
    );
  }
}
