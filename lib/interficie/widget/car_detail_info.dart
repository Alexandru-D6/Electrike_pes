import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/generated/l10n.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';

import 'attribute.dart';

CtrlPresentation ctrlPresentation = CtrlPresentation();

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
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    EditInfoCar(car: car),
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
    required this.car,
  }) : super(key: key);

  final List<String> car;

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
          onPressed: () {
            _showMyDialog(context, car);
          },
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
  _showMyDialog(BuildContext context, List<String> car) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: S.of(context).alertSureDeleteCarTitle,
      desc: S.of(context).alertSureDeleteCarContent,
      btnCancelOnPress: () {},
      btnOkIcon: (Icons.delete),
      btnOkText: "Delete",
      btnOkOnPress: () {
        ctrlPresentation.deleteCar(context, car[0]);
      },
      headerAnimationLoop: false,
    ).show();
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
          car[1], //TODO: name
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
              textColor: Colors.black87,
            ),
            Attribute(
              value: car[3],
              name: 'Model', //todo: translate S.of(context).[]
              textColor: Colors.black87,
            ),
            Attribute(
              value: car[4], //TODO: BATERIA
              name: 'Bateria', //todo: translate S.of(context).[]
              textColor: Colors.black87,
            ),
            Attribute(
              value: car[5], //TODO: POTENCIA
              name: 'Potència', //todo: translate S.of(context).[]
              textColor: Colors.black87,
            ),
            Attribute(
              value: car[5],
              name: 'Eficiencia', //todo: translate S.of(context).[]
              textColor: Colors.black87,
            ),
          ],
        )
      ],
    );
  }
}