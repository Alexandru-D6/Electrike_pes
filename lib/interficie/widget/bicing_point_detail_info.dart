import 'package:flutter/material.dart';

import '../../domini/bicing_point.dart';
import '../constants.dart';

class PointDetailInformation extends StatelessWidget {
  const PointDetailInformation({
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
          const Divider(
            height: 16,
            color: Colors.black54,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditInfoPoint(point: point),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  children: const [
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class EditInfoPoint extends StatelessWidget {
  const EditInfoPoint({
    Key? key,
    required this.point,
  }) : super(key: key);

  final BicingPoint point;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /*const Icon(
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.directions,
          ),//TODO: how to arrive
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.share,
          ),//TODO: Share
        ),*/
      ],
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
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildBicingPointInfo(
              num: point.estaciones,
              assetName: Icons.logout),
            buildBicingPointInfo(
                num: point.bicicletas,
                assetName: Icons.logout),
            buildBicingPointInfo(
                num: point.bicicletas_E,
                assetName: Icons.logout),
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
      children: [
        Icon(
            assetName
        ),
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