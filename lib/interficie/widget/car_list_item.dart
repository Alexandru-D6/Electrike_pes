import 'package:flutter/material.dart';

import '../../domini/car.dart';
import '../constants.dart';


class CarListItem extends StatelessWidget {
  const CarListItem(
      this.index, {
        Key key,
      }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    Car car = carList[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CarDetailScreen(car);
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Stack(
          children: [
            CarInfomation(car: car),
            Positioned(
              right: 40,
              child: Image.asset(
                car.image,
                height: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}