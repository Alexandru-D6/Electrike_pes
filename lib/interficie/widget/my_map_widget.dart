import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../page/garage_page.dart';

class MyMap extends StatefulWidget {
  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  double currentZoom = 13.0;
  MapController mapController = MapController();
  LatLng currentCenter = LatLng(41.390205, 2.154007);
  void _zoom() {
    currentZoom = currentZoom - 1;
    mapController.move(currentCenter, currentZoom);
  }

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
                      center: currentCenter,
                      zoom: currentZoom,
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
                            Icons.place,
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
      floatingActionButton: FloatingActionButton(
        onPressed: _zoom,
        tooltip: 'Zoom',
        child: Icon(Icons.remove_circle_outline_rounded),
      ),
    );
  }
}


