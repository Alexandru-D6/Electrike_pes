import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
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
    return FlutterMap(
      options: MapOptions(
        center: currentCenter,
        zoom: currentZoom,
        plugins: [
          MarkerClusterPlugin(),
        ],
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerClusterLayerOptions(
          maxClusterRadius: 120,
          size: const Size(40, 40),
          fitBoundsOptions: const FitBoundsOptions(
            padding: EdgeInsets.all(50),
          ),
          markers: chargePoints,
          polygonOptions: const PolygonOptions(
              borderColor: Colors.blueAccent,
              color: Colors.black12,
              borderStrokeWidth: 3),
          builder: (context, markers) {
            return FloatingActionButton(
              child: Text(markers.length.toString()),
              onPressed: null,
            );
          },
        ),
      ],
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

