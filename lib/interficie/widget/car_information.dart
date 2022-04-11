import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'attribute.dart';


class CarInfomation extends StatelessWidget {
  const CarInfomation({
    Key? key,
    required this.car,
  }) : super(key: key);

  final List<String> car;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 24, right: 24,top: 50),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: mCardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            car[1],
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
              Attribute(
                value: car[2],
                name: 'Brand', //todo: translate S.of(context).[]
              ),
              Attribute(
                value: car[3],
                name: 'Model', //todo: translate S.of(context).[]
              ),
              Attribute(
                value: car[4],
                name: 'Bateria', //todo: translate S.of(context).[]
              ),
              Attribute(
                value: car[5],
                name: 'Potència', //todo: translate S.of(context).[]
              ),
              Attribute(
                value: car[5],
                name: 'Eficiencia', //todo: translate S.of(context).[]
              ),
            ],
          )
        ],
      ),
    );
  }
}
