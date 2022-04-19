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
      body: Container(
        alignment: Alignment.center,
        child:
          SizedBox(
            width: 500.0,
            height: 500.0,
            child: OcupationChart.withSampleData(),
          )
        )
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: mPrimaryColor,
      elevation: 0,
      title: Text(S.of(context).charts),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.add_circle_rounded,
            color: Colors.white,
          ),
          onPressed: (){
          },
        )
      ],
    );
  }
}
