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
              fontWeight: FontWeight.bold,
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
              assetName: 'assets/icon/estacions.svg'),
            buildBicingPointInfo(
                num: point.bicicletas,
                assetName: 'assets/icon/bike.svg'),
            buildBicingPointInfo(
                num: point.bicicletas_E,
                assetName: 'assets/icon/bicicleta-electrica.svg'),
          ],
        )
      ],
    );
  }
}

Widget buildBicingPointInfo({
  required int num,
  required String assetName,
}) {

  return Column(
      children: [
        Image.asset(
            assetName
        ),
        Text(
          num.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
  );
}