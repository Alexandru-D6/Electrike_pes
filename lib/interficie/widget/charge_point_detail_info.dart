import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../constants.dart';

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
            ],
          )
        ],
      ),
    );
  }
}

class EditInfoPoint extends StatefulWidget {
  const EditInfoPoint({
    Key? key,
    required this.point,
  }) : super(key: key);

  final List<String> point;

  @override
  State<EditInfoPoint> createState() => _EditInfoPointState();
}

class _EditInfoPointState extends State<EditInfoPoint> {
  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    Coordenada word = Coordenada(widget.latitude, widget.longitude);
    print(word.latitud);
    bool isSaved = ctrlPresentation.favs.contains(word);
    var controller;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyStatefulWidget(),
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

double _volume = 0.0;

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.volume_up),
          tooltip: 'Increase volume by 10',
          onPressed: () {
            setState(() {
              _volume += 10;
            });
          },
        ),
        Text('Volume : $_volume')
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
          city: point[3],
          numChargePlaces: getNumChargePlaces(),
          context: context,
        ),
        buildConnectors(),
      ],
    );
  }

  Widget buildHeader({
    required String name,
    required String calle,
    required String city,
    required String numChargePlaces,
    required BuildContext context,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              const Icon(Icons.ev_station, size: 60, color: Colors.white,),
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
                    AutoSizeText(
                      city,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 1,
                    ),

                    Row(
                      children: [
                        AutoSizeText(
                          numChargePlaces.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                        const Icon(
                          Icons.local_parking,
                          color: Colors.white,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
          ],
  );

  Widget buildConnectors() => ResponsiveGridRow(
    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ResponsiveGridCol(
          xs: 6,
          md: 3,
          child: buildConnectorInfo(
            numAvailable: "4",
            numNotAvailable: "8",
            numUnknownState: "10",
            logoConnector: "assets/images/type2.png",
            nameConnector: "Schuko",
          ),
        ),
        ResponsiveGridCol(
          xs: 6,
          md: 3,
          child: buildConnectorInfo(
            numAvailable: "4",
            numNotAvailable: "5",
            numUnknownState: "52",
            logoConnector: "assets/images/type2.png",
            nameConnector: "Mennekes (Type 2)",
          ),
        ),
        ResponsiveGridCol(
          xs: 6,
          md: 3,
          child: buildConnectorInfo(
            numAvailable: "23",
            numNotAvailable: "54",
            numUnknownState: "544",
            logoConnector: "assets/images/type2.png",
            nameConnector: " CHAdeMO (DC)",
          ),
        ),
        ResponsiveGridCol(
          xs: 6,
          md: 3,
          child: buildConnectorInfo(
            numAvailable: "54",
            numNotAvailable: "24",
            numUnknownState: "453",
            logoConnector: "assets/images/type2.png",
            nameConnector: "CCS Combo (DC)",
          ),
        ),
    ],
  );

  getSchukoNum(){
    return "Schuko".allMatches(point.toString()).length;
  }

  String getNumChargePlaces() {
    return (point.length/2-3).toString();
  }
}


Widget buildConnectorInfo({
  numAvailable, 
  numNotAvailable, 
  numUnknownState, 
  logoConnector, 
  nameConnector}) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        logoConnector,
        height: 50,
      ),
      const SizedBox(width: 10),
      AutoSizeText(
        nameConnector,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      const SizedBox(width: 25),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSummary(
            icon: Icons.check_circle_rounded,
            color: Colors.greenAccent,
            info: numAvailable,
          ),
          const SizedBox(width: 10),
          buildSummary(
            icon: Icons.help,
            color: Colors.yellow,
            info: numAvailable,
          ),
          const SizedBox(width: 10),
          buildSummary(
            icon: Icons.warning,
            color: Colors.amber,
            info: numAvailable,
          ),
          const SizedBox(width: 10),
          buildSummary(
            icon: Icons.stop_circle,
            color: Colors.red,
            info: numAvailable,
          ),
        ],
      ),
    ],
  );
}

buildSummary({
  required IconData icon,
  required Color color,
  required String info,}) {
  return Column(
    children: [
      Icon(icon, color: color,),
      AutoSizeText(
        info,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      ),
    ],
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