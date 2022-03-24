

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_google_maps/flutter_google_maps.dart';


import '../../domini/bicing_point.dart';
import '../../domini/charge_point.dart';
import '../constants.dart';
import 'bicing_point_detail_info.dart';
import 'charge_point_detail_info.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final GlobalKey<GoogleMapStateBase> _key = GlobalKey<GoogleMapStateBase>();
  List<Marker> chargePoints = [];
  List<Marker> bicingPoints = [];
  List<Marker> markers = [];
  double currentZoom = 11.0;
  GeoCoord lastCoord = const GeoCoord(10.00, 20.00);
  late BuildContext ctx;


  void initMarkers(String? show){
    switch(show){
      case "chargers":
        markers = chargePoints;
        for (int i = 0; i < markers.length; ++i){
          GoogleMap.of(_key).addMarker(markers[i]);
        }
        break;
      case "bicing":
        markers = bicingPoints;
        for (int i = 0; i < markers.length; ++i){
          GoogleMap.of(_key).addMarker(markers[i]);
        }
        break;
      default:
        markers = chargePoints + bicingPoints;
        for (int i = 0; i < markers.length; ++i){
          GoogleMap.of(_key).addMarker(markers[i]);
        }
        break;
    }
    //super.initState();
  }

  @override
  Widget build(BuildContext context){
    chargePoints = buildChargerMarkers(context);
    bicingPoints = buildBicingMarkers(context);
    markers = chargePoints + bicingPoints;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GoogleMap(
              key: _key,
              markers: markers.toSet(),
              initialZoom: 9,
              //final isWebMobile = kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android)
              //minZoom: 3, //todo min zoom en web??
              initialPosition: const GeoCoord(41.8204600, 1.8676800), // Catalunya
              mapType: MapType.roadmap,
              mapStyle: null,
              interactive: true,

              onTap: (coord) => lastCoord = coord,


              mobilePreferences: const MobileMapPreferences(
                trafficEnabled: true,
                zoomControlsEnabled: true,
              ),


              webPreferences: const WebMapPreferences(
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

          //getMyLocationButton
          Positioned(
            right: 60,
            bottom: 16,
            child: Row(
              children: <Widget>[
                LayoutBuilder(
                  builder: (context, constraints) =>
                  constraints.maxWidth < 1000
                      ? Row(children: _buildMyLocButton())
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildMyLocButton(),
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }

  List<Widget> _buildMyLocButton() => [
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: FloatingActionButton(
        onPressed: (){},//_getMyLocation,
        tooltip: 'My Location',
        child: const Icon(Icons.my_location),
        backgroundColor: mCardColor,
  ),
    ),
  ];

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


  List<Marker> buildChargerMarkers(BuildContext context) {
    chargePoints = [];
    for (var i = 0; i < chargePointList.length; ++i) {
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

  List<Marker> buildBicingMarkers(BuildContext context) {
    bicingPoints = [];
    for (var i = 0; i < bicingPointList.length; ++i) {
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
  return Marker(
      GeoCoord(lat, long),
      //icon: Icon(Icons.power),
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
    icon: "assets/images/bike.png",
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
