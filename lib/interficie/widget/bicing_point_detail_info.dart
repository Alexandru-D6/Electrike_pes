import 'package:flutter/material.dart';

import '../../domini/bicing_point.dart';
import '../constants.dart';

class BicingPointDetailInformation extends StatelessWidget {
  const BicingPointDetailInformation({
    Key? key,
    required this.point,
  }) : super(key: key);

  final BicingPoint point;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: mPrimaryColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          PointInfo(point: point),
        ],
      ),
    );
  }
}

class PointInfo extends StatelessWidget {
  const PointInfo({
    Key? key,
    required this.point,
  }) : super(key: key);

  final BicingPoint point;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ListTile(
          leading: const Icon(Icons.pedal_bike, color: Colors.white, size: 45,),
          title: Text(
            point.nom,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
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
                num: point.estaciones,
                assetName: Icons.assistant_navigation),
            buildBicingPointInfo(
                num: point.bicicletas,
                assetName: Icons.pedal_bike),
            buildBicingPointInfo(
                num: point.bicicletasE,
                assetName: Icons.electric_bike),
          ],
        )
      ],
    );
  }
}

Widget buildBicingPointInfo({
  required int num,
  required IconData assetName,
}) {

  return Column(

    children: <Widget>[
      Icon(assetName, size: 45, color: mCardColor),
      Text(
        num.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}