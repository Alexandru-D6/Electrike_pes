import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_project/domini/charge_point.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:sign_button/constants.dart';

import '../page/garage_page.dart';

class MyMap extends StatefulWidget {
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
          child: Container(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getMyLocation,
        tooltip: 'Zoom',
        child: Icon(Icons.my_location),
      ),
    );
  }

  List<Marker> buildMarkers() {
    for (var i = 0; i < chargePointList.length; ++i) {
      chargePoints.add(
          buildMarker(
            lat: chargePointList[i].lat,
            long: chargePointList[i].long,
            charger: chargePointList[i].chargerType,
          )
      );
    }
    setState(() {

    });
    return chargePoints;
  }
}

Marker buildMarker({
  required double lat,
  required double long,
  required String charger,
}){
  return Marker(
    width: 80.0,
    height: 80.0,
    point: LatLng(lat, long),
    builder: (ctx)=>
        Container(
          child:IconButton(
            icon: Icon(Icons.place),
            color: Color(0xFF203e5a),
            iconSize: 45.0,
            onPressed: (){
              showModalBottomSheet(
                  context: ctx,
                  builder: (builder){
                    return Container(
                      color: Colors.white,
                      child: Center(
                        child: Text(charger),
                      ),
                    );
                  });
            },
          ),
        ),
  );
}
