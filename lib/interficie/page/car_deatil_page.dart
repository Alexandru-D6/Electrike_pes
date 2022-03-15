import 'package:flutter/material.dart';

import '../../domini/car.dart';
import '../widget/car_detail_info.dart';
import '../widget/lateral_menu_widget.dart';

class CarDetailPage extends StatelessWidget {
  final Car car;

  CarDetailPage(this.car);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/map.png',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
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
        ),
      ),
    );
  }
}