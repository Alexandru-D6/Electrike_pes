import 'package:flutter/material.dart';

import '../../domini/car.dart';
import '../constants.dart';
import 'car_detail_info.dart';
import 'car_information.dart';


class CarListItem extends StatelessWidget {
  const CarListItem(
      this.index, {
        Key? key,
      }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    Car car = carList[index];
    return GestureDetector(
      onTap: () {
      showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0x00000000), //color transparente
        builder: (builder){
          return Stack(
            children: [
              Positioned(
                left: 24,
                right: 24,
                bottom: 24,
                child: Stack(
                  children: [
                    CarDetailInfomation(car: car),
                    Positioned(
                      right: 16,
                      child: Image.asset(
                        car.image,
                        height: 100,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
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