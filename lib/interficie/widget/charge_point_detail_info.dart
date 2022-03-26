import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'attribute.dart';

class ChargePointDetailInformation extends StatelessWidget {
  const ChargePointDetailInformation({
    Key? key,
    required this.chargePoint,
  }) : super(key: key);

  final List<String> chargePoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: mPrimaryColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          PointInfo(point: chargePoint),
          const Divider(
            height: 16,
            color: Colors.black54,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditInfoPoint(point: chargePoint),
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

class EditInfoPoint extends StatelessWidget {
  const EditInfoPoint({
    Key? key,
    required this.point,
  }) : super(key: key);

  final List<String> point;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /*IconButton(
          onPressed: () {
            point.fav = !point.fav;
          },
          color: point.fav ? Colors.red : Colors.black45,
          icon: point.fav ?
          const Icon(
            Icons.favorite,
          ) : const Icon(
            Icons.favorite_border,
          ) ,//TODO: Add like
        ),*/
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.share,
          ),//TODO: Share
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

  final List<String> point;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          point[1],//name
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
        AutoSizeText(
          point[3], //calle
          style: const TextStyle(
            color: Colors.white,
          ),
          maxLines: 1,
        ),
        const AutoSizeText(
          "Barcelona",//todo: point[?]
          style: TextStyle(
            color: Colors.white,
          ),
          maxLines: 1,
        ),
        const SizedBox(
          height: 16,
        ),
        //todo: not working properly
        SingleChildScrollView(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              for(var i = 3; i < point.length; i+=2) ...[
                Row(
                  children: [
                    if (point[i+1] == "6") const Icon(Icons.power, color: Colors.amber,)
                    else  const Icon(Icons.power, color: Colors.green,),
                    Attribute(
                      value: point[i],
                      name: 'Tipus',
                      textColor: Colors.black87,
                    ),
                  ]
                )
              ],
            ],
          ),
        ),
      ],
    );
  }
}