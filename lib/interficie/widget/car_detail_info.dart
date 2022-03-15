import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domini/car.dart';
import '../constants.dart';
import 'attribute.dart';

class CarDetailInfomation extends StatelessWidget {
  const CarDetailInfomation({
    Key? key,
    required this.car,
  }) : super(key: key);

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: mPrimaryColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          CarInfo(car: car),
          Divider(
            height: 16,
            color: Colors.black54,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  children: [
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
        FlatButton(
          onPressed: () {},
          color: mCardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          child: Text(
            'Edit',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        FlatButton(
          onPressed: () {},
          color: mCardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          child: Text(
            'Delete',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
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
          children: [
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

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$${car.price}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'price/hr',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Attribute(
              value: car.brand,
              name: 'Brand',
              textColor: Colors.black87,
            ),
            Attribute(
              value: car.model,
              name: 'Model No',
              textColor: Colors.black87,
            ),
            Attribute(
              value: car.co2,
              name: 'CO2',
              textColor: Colors.black87,
            ),
            Attribute(
              value: car.fuelCons,
              name: 'Fule Cons.',
              textColor: Colors.black87,
            ),
          ],
        )
      ],
    );
  }
}