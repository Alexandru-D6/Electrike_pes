import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'bicing_point_detail_info.dart';
import 'charge_point_detail_info.dart';


CtrlPresentation ctrlPresentation = CtrlPresentation();

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Set<Marker> chargePoints = {};
  Set<Marker> bicingPoints = {};
  Set<Marker> markers = {};
  double currentZoom = 11.0;
  GeoCoord lastCoord = const GeoCoord(10.00, 20.00);
  late BuildContext ctx;
  GeoCoord lastPosition = const GeoCoord(0.0,0.0);

  void initMarkers(String? show){
    //GoogleMap.of(ctrlPresentation.getMapKey())addMarker(lastPosition, icon: "assets/images/me.png"));
    switch(show){
      case "chargers":
        markers = chargePoints;
        for (int i = 0; i < markers.length; ++i){
          GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(markers.elementAt(i));
        }
        break;
      case "bicing":
        markers = bicingPoints;
        for (int i = 0; i < markers.length; ++i){
          GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(markers.elementAt(i));
        }
        break;
      default:
        markers = chargePoints.union(bicingPoints);
        for (int i = 0; i < markers.length; ++i){
          GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(markers.elementAt(i));
        }
        break;
    }
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chargePoints = buildChargerMarkers(context);
    bicingPoints = buildBicingMarkers(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GoogleMap(
              key: ctrlPresentation.getMapKey(),
              markers: chargePoints.union(bicingPoints),
              initialZoom: 9,
              //final isWebMobile = kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android)
              //minZoom: 3, //todo min zoom en web??
              initialPosition: const GeoCoord(41.8204600, 1.8676800), // Catalunya
              mapType: MapType.roadmap,
              mapStyle: "",
              interactive: true,

              onLongPress: (markerId) {
              },


                    /*onTap: (markerId) async {
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
              },*/

              mobilePreferences: const MobileMapPreferences(
                myLocationEnabled:true,
                myLocationButtonEnabled: true,
                rotateGesturesEnabled: true,
                compassEnabled: true,
                zoomGesturesEnabled:true,

                trafficEnabled: true,
                zoomControlsEnabled: true,
              ),


              webPreferences: const WebMapPreferences(
                streetViewControl:true,
                mapTypeControl: true,
                scrollwheel: true,
                panControl: true,
                overviewMapControl:false,

                fullscreenControl: true,
                zoomControl: true,
                dragGestures: false,
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
        child: const Icon(Icons.visibility_off),
        onPressed: () {
          GoogleMap.of(ctrlPresentation.getMapKey())?.clearMarkers();
        },
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: FloatingActionButton(
        backgroundColor: mCardColor,
        child: const Icon(Icons.visibility),
        onPressed: () {
          GoogleMap.of(ctrlPresentation.getMapKey())?.clearMarkers();
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
          GoogleMap.of(ctrlPresentation.getMapKey())?.clearMarkers();
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
          GoogleMap.of(ctrlPresentation.getMapKey())?.clearMarkers();
          initMarkers("bicing");
        },
      ),
    ),
  ];


  Set<Marker> buildChargerMarkers(BuildContext context) {
    chargePoints = {};
    List<Coordenada> coordsChargers = ctrlPresentation.getChargePointList();
    for (var i = 0; i < coordsChargers.length; ++i) {
      chargePoints.add(
          buildChargerMarker(
            index: i,
            lat: coordsChargers[i].latitud,
            long: coordsChargers[i].longitud,
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
    List<Coordenada> coordsBicing = ctrlPresentation.getBicingPointList();
    for (var i = 0; i < coordsBicing.length; ++i) {
      bicingPoints.add(
          buildBicingMarker(
            lat: coordsBicing[i].latitud,
            long: coordsBicing[i].longitud,
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
  List<String> infoChargerPoint = ctrlPresentation.getInfoCharger(lat, long);
  return Marker(
      GeoCoord(lat, long),
      icon: "assets/images/me.png",
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
                          ChargePointDetailInformation(
                              chargePoint: infoChargerPoint,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
  );
}

showInfoCharger(BuildContext context, double lat, double long) {
  List<String> infoChargerPoint = ctrlPresentation.getInfoCharger(lat, long);
  //print(infoChargerPoint);
  showModalBottomSheet(
      context: context,
      backgroundColor: cTransparent,
      builder: (builder){
        print(lat);
        return Stack(
          children: [
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: Stack(
                children: [
                  ChargePointDetailInformation(chargePoint: infoChargerPoint, latitude: lat, longitude: long,),
                ],
              ),
            ),
          ],
        );
      });
}

Marker buildBicingMarker({
  required double lat,
  required double long,
  required BuildContext context,
}) {
  List<String> infoBicingPoint = <String>[];
  ctrlPresentation.getInfoBicing(lat, long).then((element){
    infoBicingPoint = element;
  });
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
                              BicingPointDetailInformation(
                                  name: infoBicingPoint[0],
                                  docks: infoBicingPoint[5],
                                  bicisE: infoBicingPoint[4],
                                  bicisM: infoBicingPoint[3],
                              ),
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
