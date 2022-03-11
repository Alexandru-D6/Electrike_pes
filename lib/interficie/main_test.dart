import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MaterialApp(
      home: MyMap(),
  ));
}


class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);


  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            child: Column(
              children: [
                Flexible(
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(41.390205, 2.154007),
                      zoom: 11
                    ),
                    layers: [
                    TileLayerOptions(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(
                        markers: [
                          //iterar marcadores por aqui
                          Marker(
                          point: LatLng(41.390205, 2.154007),
                          builder: (ctx) => const Icon(
                            Icons.pin_drop,
                            color: Colors.deepPurpleAccent,
                            size: 45,
                          ),
                        ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}


