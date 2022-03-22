import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MapScreen(),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  /*List<Marker> chargePoints = [];
  List<Marker> bicingPoints = [];
  List<Marker> markers = [];
  double currentZoom = 11.0;
  MapController mapController = MapController();
  LatLng currentCenter = LatLng(41.390205, 2.154007);
  void _getMyLocation() {
    //getMyLocation();
    mapController.move(currentCenter, currentZoom);
  }
*/
  static const _initialCameraPosition = CameraPosition(target: LatLng(41.390205, 2.154007),
                                    zoom: 11.5,
  );

  late GoogleMapController _googleMapController;
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext constext) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
      ),
          floatingActionButton: FloatingActionButton (
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.black,
            onPressed: () => _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition),
    ),
    child: const Icon(Icons.center_focus_strong),
    ),
    );
  }


  /*
  @override
  Widget build(BuildContext context) {
    //chargePoints = buildChargerMarkers();
    //bicingPoints = buildBicingMarkers();
    markers = chargePoints + bicingPoints;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  maxZoom: 18.25,
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
                    markers: markers,
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
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getMyLocation,
        tooltip: 'My Location',
        child: const Icon(Icons.my_location),
      ),
    );
  }
*/

  /*List<Marker> buildChargerMarkers() {
    chargePoints = [];
    for (var i = 0; i < chargePointList.length; ++i) {
      chargePoints.add(
          buildChargerMarker(
            index: i,
            lat: chargePointList[i].lat,
            long: chargePointList[i].long,
          )
      );
    }
    setState(() {
    });
    return chargePoints;
  }*/

  /*List<Marker> buildBicingMarkers() {
    bicingPoints = [];
    for (var i = 0; i < bicingPointList.length; ++i) {
      bicingPoints.add(
          buildBicingMarker(
            index: i,
            lat: bicingPointList[i].lat,
            long: bicingPointList[i].long,
          )
      );
    }
    setState(() {
    });
    return bicingPoints;
  }
}*/
/*
Marker buildChargerMarker({
  required int index,
  required double lat,
  required double long,
}){
  ChargePoint point = chargePointList[index];
  return Marker(
    width: 50.0,
    height: 50.0,
    point: LatLng(lat, long),
    builder: (ctx)=>
        IconButton(
          icon: const Icon(Icons.power_rounded),
          color: mPrimaryColor,
          iconSize: 45.0,
          onPressed: (){
            showModalBottomSheet(
                context: ctx,
                backgroundColor: cTransparent,
                builder: (builder){
                  return Stack(
                    children: [
                      Positioned(
                        left: 24,
                        right: 24,
                        bottom: 24,
                        child: Stack(
                          children: [
                            ChargePointDetailInformation(point: point),
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

Marker buildBicingMarker({
  required int index,
  required double lat,
  required double long,
}) {
  BicingPoint point = bicingPointList[index];
  return Marker(
    width: 50.0,
    height: 50.0,
    point: LatLng(lat, long),
    builder: (ctx) =>
        IconButton(
          icon: const Icon(Icons.pedal_bike),
          color: cBicingRed,
          iconSize: 45.0,
          onPressed: () {
            showModalBottomSheet(
                context: ctx,
                backgroundColor: cTransparent,
                builder: (builder) {
                  return Stack(
                    children: [
                      Positioned(
                        left: 24,
                        right: 24,
                        bottom: 24,
                        child: Stack(
                          children: [
                            BicingPointDetailInformation(point: point),
                            /*const Positioned(
                              right: 16,
                              /*child: Icon(

                              ),*/
                            )*/
                          ],
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
  );*/
}
