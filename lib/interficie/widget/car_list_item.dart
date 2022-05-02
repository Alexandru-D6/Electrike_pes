import 'dart:io';

import 'package:flutter/material.dart';
import '../constants.dart';
import 'car_detail_info.dart';
import 'car_information.dart';


class CarListItem extends StatefulWidget {
  const CarListItem(
      this.car, {
        Key? key,
      }) : super(key: key);

  final List<String> car;

  @override
  State<CarListItem> createState() => _CarListItemState();
}

class _CarListItemState extends State<CarListItem> {
  bool isBrand = true;

  @override
  void initState(){
    ctrlPresentation.isBrand(widget.car[2]).then((value) {
      isBrand = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String carImage = "assets/brandCars/"+widget.car[2].toLowerCase()+".png";
    //ctrlPresentation.isBrand(widget.car[2]).then((value) => isBrand = value);
    if(isBrand) {
      carImage = "assets/brandCars/"+widget.car[2].toLowerCase()+".png";
    } else {
      carImage = "assets/brandCars/defaultBMW.png";
    }
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
                    CarDetailInfomation(car: widget.car),
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
            CarInfomation(car: widget.car),
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