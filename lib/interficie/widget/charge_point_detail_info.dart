import 'package:flutter/material.dart';

import '../../domini/charge_point.dart';
import '../constants.dart';
import 'attribute.dart';

class PointDetailInformation extends StatelessWidget {
  const PointDetailInformation({
    Key? key,
    required this.point,
  }) : super(key: key);

  final ChargePoint point;

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
                    EditInfoCar(),
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

class EditInfoCar extends StatelessWidget {
  const EditInfoCar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},//TODO: EditInfoCar
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF203e5a)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0),
                      side: BorderSide(color: mCardColor)
                  )
              )
          ),
          child: const Text(
            'Edit',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},//TODO: EditInfoCar
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF203e5a)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0),
                      side: BorderSide(color: mCardColor)
                  )
              )
          ),
          child: const Text(
            'Delete',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class PointInfo extends StatelessWidget {
  const PointInfo({
    Key? key,
    required this.point,
  }) : super(key: key);

  final ChargePoint point;

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
        Text(
          point.carrer,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          point.ciutat,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Attribute(
              value: point.potencia.toString() + " (kW)",
              name: 'Potència',
              textColor: Colors.black87,
            ),
            Attribute(
              value: point.tipus,
              name: 'Tipus',
              textColor: Colors.black87,
            ),
          ],
        )
      ],
    );
  }
}