import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';

class BicingPointDetailInformation extends StatelessWidget {
  const BicingPointDetailInformation({
    Key? key,
    required this.name,
    required this.docks,
    required this.bicisE,
    required this.bicisM,
  }) : super(key: key);

  //final BicingPoint point;
  final String name;
  final String docks;
  final String bicisE;
  final String bicisM;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: mPrimaryColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          PointInfo(
            name: name,
            docks: docks,
            bicisE: bicisE,
            bicisM: bicisM,
          ),
        ],
      ),
    );
  }
}

class PointInfo extends StatelessWidget {
  const PointInfo({
    Key? key,
    required this.name,
    required this.docks,
    required this.bicisE,
    required this.bicisM,
  }) : super(key: key);

  final String name;
  final String docks;
  final String bicisE;
  final String bicisM;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ListTile(
          leading: const Icon(Icons.pedal_bike, color: Colors.white, size: 45,),
          title: AutoSizeText(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            maxLines: 1,
          ),
        ),
        const Divider(
          height: 16,
          color: Colors.black54,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildBicingPointInfo(
                num: docks,
                assetName: Icons.local_parking),
            buildBicingPointInfo(
                num: bicisM,
                assetName: Icons.pedal_bike),
            buildBicingPointInfo(
                num: bicisE,
                assetName: Icons.electric_bike),
          ],
        )
      ],
    );
  }
}

Widget buildBicingPointInfo({
  required String num,
  required IconData assetName,
}) {
  return Column(
    children: <Widget>[
      Icon(assetName, size: 45, color: mCardColor),
      AutoSizeText(
        num,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      ),
    ],
  );
}