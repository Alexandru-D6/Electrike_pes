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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        buildHeader(
          name: point[1],
          calle: point[2],
          city: "Barcelona", //todo: call point[4]
          context: context,
        ),
        buildConnectors(
          context: context,
        ),
        /*for(var i = 3; i < point.length; i+=2) ...[
          Row(
              children: [
                getChargerState(point[i+1]),
                Attribute(
                  value: point[i],
                  name: 'Tipus',
                  textColor: Colors.black87,
                ),
              ]
          )
        ],*/
      ],
    );
  }

  Widget buildHeader({
    required String name,
    required String calle,
    required String city,
    required BuildContext context,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              /*Image.asset(
                "assets/images/charge_point.png",
                height: 125,
              ),*/
              const Icon(Icons.ev_station, size: 50, color: Colors.white,),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      calle,
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
                    const SizedBox(height: 16),
                  ],
                ),
              ),
          ],
  );

  Widget buildConnectors({
    required BuildContext context,
  }) =>  SingleChildScrollView(
      child: Column(
          children: <Widget>[
            for(var i = 3; i < point.length; i+=2) ...[
              Row(
                  children: [
                    getChargerState(point[i+1]),
                    Attribute(
                      value: point[i],
                      name: 'Tipus',
                      textColor: Colors.black87,
                    ),
                  ]
              )
            ],
          ]
      )
  );
}



getChargerState(param) {
  //0 -> Available, 1 -> Occupied, 2 -> Faulted, 3 -> Unavailable, 4 -> Reserved, 5 -> Charging
  switch (param){
    case "0": //0 -> Available
      return const Icon(Icons.not_started, color: Colors.greenAccent,);
    case "1": //1 -> Occupied
      return const Icon(Icons.stop_circle, color: Colors.red,);
    case "2": //2 -> Faulted
      return const Icon(Icons.dangerous, color: Colors.red,);
    case "3": //3 -> Unavailable
      return const Icon(Icons.dangerous, color: Colors.red,);
    case "4": //4 -> Reserved
      return const Icon(Icons.pause_circle_filled, color: Colors.yellow,);
    case "5": //5 -> Charging
      return const Icon(Icons.stop_circle, color: Colors.red,);
    default: //6 -> ??
      return const Icon(Icons.help, color: Colors.amber,);

  }
}