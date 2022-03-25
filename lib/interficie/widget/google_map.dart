// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:location/location.dart';


import '../../domini/bicing_point.dart';
import '../../domini/charge_point.dart';
import '../constants.dart';
import 'bicing_point_detail_info.dart';
import 'charge_point_detail_info.dart';

CtrlPresentation ctrlPresentation = CtrlPresentation();

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final GlobalKey<GoogleMapStateBase> _key = GlobalKey<GoogleMapStateBase>();
  Set<Marker> chargePoints = {};
  Set<Marker> bicingPoints = {};
  Set<Marker> markers = {};
  double currentZoom = 11.0;
  GeoCoord lastCoord = const GeoCoord(10.00, 20.00);
  late BuildContext ctx;
  Location location = Location();
  GeoCoord lastPosition = const GeoCoord(0.0,0.0);

  void initMarkers(String? show){
    //GoogleMap.of(_key)arker(lastPosition, icon: "assets/images/me.png"));
    switch(show){
      case "chargers":
        markers = chargePoints;
        for (int i = 0; i < markers.length; ++i){
          GoogleMap.of(_key).addMarker(markers.elementAt(i));
        }
        break;
      case "bicing":
        markers = bicingPoints;
        for (int i = 0; i < markers.length; ++i){
          GoogleMap.of(_key).addMarker(markers.elementAt(i));
        }
        break;
      default:
        markers = chargePoints.union(bicingPoints);
        for (int i = 0; i < markers.length; ++i){
          GoogleMap.of(_key).addMarker(markers.elementAt(i));
        }
        break;
    }
    //super.initState();
  }

  @override
  Widget build(BuildContext context){
    chargePoints = buildChargerMarkers(context);
    bicingPoints = buildBicingMarkers(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GoogleMap(
              key: _key,
              markers: chargePoints.union(bicingPoints),
              initialZoom: 9,
              //final isWebMobile = kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android)
              //minZoom: 3, //todo min zoom en web??
              initialPosition: const GeoCoord(41.8204600, 1.8676800), // Catalunya
              mapType: MapType.roadmap,
              mapStyle: null,
              interactive: true,

              onLongPress: (coord) => GoogleMap.of(_key).addMarker(Marker(coord, icon: "assets/images/me.png")),

              onTap: (coord) async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: const Text(
                      'This dialog was opened by tapping on the marker!\n'
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: Navigator.of(context).pop,
                        child: const Text('CLOSE'),
                      ),
                    ],
                  ),
                );
              },


              mobilePreferences: const MobileMapPreferences(
                myLocationEnabled:true,
                myLocationButtonEnabled: true,
                rotateGesturesEnabled: true,
                zoomGesturesEnabled:true,

                trafficEnabled: true,
                zoomControlsEnabled: true,
              ),


              webPreferences: const WebMapPreferences(
                streetViewControl:true,
                mapTypeControl: true,
                scrollwheel: true,
                panControl: true,
                overviewMapControl:true,

                fullscreenControl: true,
                zoomControl: true,
              ),
            ),
          ),


          Positioned(
            left: 16,
            right: kIsWeb ? 60 : 16,
            bottom: 16,
            child: Row(
              children: <Widget>[
                LayoutBuilder(
                  builder: (context, constraints) =>
                  constraints.maxWidth < 1000
                      ? Row(children: _buildClearButtons())
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildClearButtons(),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  List<Widget> _buildClearButtons() => [
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: FloatingActionButton(
        backgroundColor: mCardColor,
        child: const Icon(Icons.filter_alt_off),
        onPressed: () {
          GoogleMap.of(_key).clearMarkers();
          initMarkers("all");
        },
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: FloatingActionButton(
        backgroundColor: mCardColor,
        child: const Icon(Icons.power),
        onPressed: () {
          GoogleMap.of(_key).clearMarkers();
          initMarkers("chargers");
        },
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: FloatingActionButton(
        backgroundColor: mCardColor,
        child: const Icon(Icons.pedal_bike),
        onPressed: () {
          GoogleMap.of(_key).clearMarkers();
          initMarkers("bicing");
        },
      ),
    ),
  ];


  Set<Marker> buildChargerMarkers(BuildContext context) {
    chargePoints = {};
    for (var i = 0; i < ctrlPresentation.getChargePointList().length; ++i) {
      chargePoints.add(
          buildChargerMarker(
            index: i,
            lat: chargePointList[i].lat,
            long: chargePointList[i].long,
            context: context,
          )
      );
    }
    setState(() {
    });
    return chargePoints;
  }

  Set<Marker> buildBicingMarkers(BuildContext context) {
    bicingPoints = {};
    for (var i = 0; i < ctrlPresentation.getBicingPointList().length; ++i) {
      bicingPoints.add(
          buildBicingMarker(
            index: i,
            lat: bicingPointList[i].lat,
            long: bicingPointList[i].long,
            context: context,
          )
      );
    }
    setState(() {
    });
    return bicingPoints;
  }
}

Marker buildChargerMarker({
  required int index,
  required double lat,
  required double long,
  required BuildContext context,
}){
  ChargePoint point = chargePointList[index];
  //List<String> cPoint = ctrlPresentation.getChargePoint(lat, long); //todo
  return Marker(
      GeoCoord(lat, long),
      icon: "assets/images/charge_point.png",
      onTap: (markerId)=>
          showModalBottomSheet(
              context: context,
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
              }),
  );
}

Marker buildBicingMarker({
  required int index,
  required double lat,
  required double long,
  required BuildContext context,
}) {
  BicingPoint point = bicingPointList[index];
  return Marker(
    GeoCoord(lat, long),
    icon: "assets/images/bike.png", //todo: al poner custom marker no sale en la primera carga
    onTap: (ctx) =>
              showModalBottomSheet(
                  context: context,
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
                  }),
  );
}


const contentString = r'''
<div id="content">
  <div id="siteNotice"></div>
  <h1 id="firstHeading" class="firstHeading">Uluru</h1>
  <div id="bodyContent">
    <p>
      <b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large 
      sandstone rock formation in the southern part of the 
      Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) 
      south west of the nearest large town, Alice Springs; 450&#160;km 
      (280&#160;mi) by road. Kata Tjuta and Uluru are the two major 
      features of the Uluru - Kata Tjuta National Park. Uluru is 
      sacred to the Pitjantjatjara and Yankunytjatjara, the 
      Aboriginal people of the area. It has many springs, waterholes, 
      rock caves and ancient paintings. Uluru is listed as a World 
      Heritage Site.
    </p>
    <p>
      Attribution: Uluru, 
      <a href="http://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">
        http://en.wikipedia.org/w/index.php?title=Uluru
      </a>
      (last visited June 22, 2009).
    </p>
  </div>
</div>
''';
