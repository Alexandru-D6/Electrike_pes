import 'package:flutter/material.dart';

import '../../domini/bicing_point.dart';
import '../constants.dart';
import 'attribute.dart';

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
        Text(
          point.nom,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildBicingPointInfo(
              text: point.estaciones,
              icon: Icons.logout),
            buildBicingPointInfo(
                text: point.bicicletas,
                icon: Icons.logout),
            buildBicingPointInfo(
                text: point.bicicletas_E,
                icon: Icons.logout),
          ],
        )
      ],
    );
  }
}

Widget buildBicingPointInfo({
  required int text,
  required IconData icon,
}) {
  const color = Colors.white;
  const hoverColor = Colors.white70;

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text.toString(), style: const TextStyle(fontSize: 18, color: color)),
    hoverColor: hoverColor,
  );
}