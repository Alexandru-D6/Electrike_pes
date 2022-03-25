import 'package:flutter/material.dart';

import '../constants.dart';
import 'attribute.dart';

class CarDetailInfomation extends StatelessWidget {
  const CarDetailInfomation({
    Key? key,
    required this.car,
  }) : super(key: key);

  final List<String> car;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: mPrimaryColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          CarInfo(car: car),
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
            backgroundColor: MaterialStateProperty.all<Color>(mCardColor),
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
              backgroundColor: MaterialStateProperty.all<Color>(mPrimaryColor),
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



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              '369',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Ride',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        )
      ],
    );
  }


class CarInfo extends StatelessWidget {
  const CarInfo({
    Key? key,
    required this.car,
  }) : super(key: key);

  final List<String> car;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$${car[1]}', //TODO: name NO EL PRECIO
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
              name: 'Brand',
              textColor: Colors.black87,
            ),
            Attribute(
              value: car[3],
              name: 'Model No',
              textColor: Colors.black87,
            ),
            Attribute(
              value: car[4], //TODO: BATERIA
              name: 'Bateria', //TODO: TRANSLATOR
              textColor: Colors.black87,
            ),
            Attribute(
              value: car[5], //TODO: POTENCIA
              name: 'Potència', //TODO: TRANSLATOR
              textColor: Colors.black87,
            ),
            Attribute(
              value: car[5],
              name: 'Eficiencia',
              textColor: Colors.black87,
            ),
          ],
        )
      ],
    );
  }
}