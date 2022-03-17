import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'widget/lateral_menu_widget.dart';

import 'page/garage_page.dart';


void main() {
  runApp(MaterialApp(
      home: MyMap(),
  ));
}

class MyMap extends StatefulWidget {
  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),

        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.apps),
            tooltip: 'Menú principal',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GaragePage()),
                );
              }
          )
        ],
        title: const Text('Electrike'),
        backgroundColor: Colors.greenAccent,
      ),
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
                            Icons.place,
                            color: Colors.deepPurpleAccent,
                            size: 45,
                          ),
                        ),
                        ],
                      ),
                    ],
                  ),
                    Padding(
                    padding: const EdgeInsets.symetric(vertical: 34.0,horizontal: 16.0),
                    child: Column(
                      children: [
                        Card(
                          child: TextField(),
                        ),
                      ],
                    ),
                  )
                ),
              ],
            ),
          ),
      ),
    );
  }
}


