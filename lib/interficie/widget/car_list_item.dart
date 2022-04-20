import 'package:flutter/material.dart';
import '../constants.dart';
import 'car_detail_info.dart';
import 'car_information.dart';


class CarListItem extends StatelessWidget {
  const CarListItem(
      this.car, {
        Key? key,
      }) : super(key: key);

  final List<String> car;

  @override
  Widget build(BuildContext context) {
    String carImage = "assets/brandCars/RAYO.png"; //pos 0 es la fot del coche
    return GestureDetector(
      onTap: () {
      showModalBottomSheet(
        context: context,
        backgroundColor: cTransparent, //color transparente
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
                        carImage,
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
                carImage,
                height: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}