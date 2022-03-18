import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/widget/charge_point_detail_info.dart';
import 'package:latlong2/latlong.dart';

import '../../domini/charge_point.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  List<Marker> chargePoints = [];
  double currentZoom = 11.0;
  MapController mapController = MapController();
  LatLng currentCenter = LatLng(41.390205, 2.154007);

  void _getMyLocation() {
    //getMyLocation();
    mapController.move(currentCenter, currentZoom);
  }

  @override
  Widget build(BuildContext context) {
    chargePoints = buildMarkers();
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
                    center: currentCenter,
                    zoom: currentZoom,
                  ),
                  layers: [
                  TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(
                      markers: chargePoints,
                        //iterar marcadores por aqui
                        //buildMarker(),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getMyLocation,
        tooltip: 'Zoom',
        child: const Icon(Icons.my_location),
      ),
    );
  }

  List<Marker> buildMarkers() {
    for (var i = 0; i < chargePointList.length; ++i) {
      chargePoints.add(
          buildMarker(
            index: i,
            lat: chargePointList[i].lat,
            long: chargePointList[i].long,
            charger: chargePointList[i].tipus,
          )
      );
    }
    setState(() {

    });
    return chargePoints;
  }
}

Marker buildMarker({
  required int index,
  required double lat,
  required double long,
  required String charger,
}){
  ChargePoint point = chargePointList[index];
  return Marker(
    width: 50.0,
    height: 50.0,
    point: LatLng(lat, long),
    builder: (ctx)=>
        IconButton(
          icon: const Icon(Icons.place),
          color: const Color(0xFF203e5a),
          iconSize: 45.0,
          onPressed: (){
            showModalBottomSheet(
                context: ctx,
                backgroundColor: const Color(0x00000000),
                builder: (builder){
                  return Stack(
                    children: [
                      Positioned(
                        left: 24,
                        right: 24,
                        bottom: 24,
                        child: Stack(
                          children: [
                            PointDetailInformation(point: point),
                            Positioned(
                              right: 16,
                              child: Image.asset(
                                "assets/images/charge_point.png",
                                height: 125,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
  );
}

