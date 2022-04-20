import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
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
  Set<Marker> favBicingPoints = {};
  Set<Marker> favChargePoints = {};
  Set<Marker> markers = {};
  double currentZoom = 11.0;
  GeoCoord lastCoord = const GeoCoord(10.00, 20.00);
  late BuildContext ctx;
  GeoCoord lastPosition = const GeoCoord(0.0,0.0);

  void initMarkers(String? show){
    switch(show){
      case "chargers":
        GoogleMap.of(ctrlPresentation.getMapKey())?.clearMarkers();
        markers = chargePoints;
        for (int i = 0; i < markers.length; ++i){
          GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(markers.elementAt(i));
        }
        break;
      case "bicing":
        GoogleMap.of(ctrlPresentation.getMapKey())?.clearMarkers();
        markers = bicingPoints;
        for (int i = 0; i < markers.length; ++i){
          GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(markers.elementAt(i));
        }
        break;
      case "favs":
        GoogleMap.of(ctrlPresentation.getMapKey())?.clearMarkers();
        markers = favBicingPoints.union(favChargePoints);
        for (int i = 0; i < markers.length; ++i){
          GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(markers.elementAt(i));
        }
        break;
      case "all":
        GoogleMap.of(ctrlPresentation.getMapKey())?.clearMarkers();
        markers = chargePoints.union(bicingPoints);
        for (int i = 0; i < markers.length; ++i){
          GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(markers.elementAt(i));
        }
        break;
      default:
        GoogleMap.of(ctrlPresentation.getMapKey())?.clearMarkers();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    chargePoints = buildChargerMarkers(context, 1);
    favChargePoints = buildChargerMarkers(context, 2);

    bicingPoints = buildBicingMarkers(context, 1);
    favBicingPoints = buildBicingMarkers(context, 2);

    markers = chargePoints.union(bicingPoints);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GoogleMap(
              key: ctrlPresentation.getMapKey(),
              markers: markers,
              initialZoom: 9,
              //final isWebMobile = kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android)
              //minZoom: 3, //todo min zoom en web??
              initialPosition: const GeoCoord(41.8204600, 1.8676800), // Catalunya
              mapType: MapType.roadmap,
              mapStyle: null,
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

                trafficEnabled: false,
                zoomControlsEnabled: true,
              ),


              webPreferences: const WebMapPreferences(
                streetViewControl:true,
                mapTypeControl: false,
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

  Widget button(
      { required String onPressed,
        required String heroTag,
        required String toolTip,
        required Icon icon}) {
    return FloatingActionButton(
      onPressed: (){
        initMarkers(onPressed);
      },
      heroTag: heroTag,
      tooltip: toolTip,
      child: icon,
      backgroundColor: mCardColor,
    );
  }

  List<Widget> _buildClearButtons() => [
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: AnimatedFloatingActionButton(
          fabButtons: <Widget>[
            button(onPressed: "default", heroTag: "hide", toolTip: "Hide markers", icon: const Icon(Icons.visibility_off)),
            button(onPressed: "all", heroTag: "all", toolTip: "Show all markers", icon: const Icon(Icons.visibility)),
            button(onPressed: "chargers", heroTag: "charger", toolTip: "See only chargers", icon: const Icon(Icons.power)),
            button(onPressed: "bicing", heroTag: "bicing", toolTip: "See only bicing", icon: const Icon(Icons.pedal_bike)),
            button(onPressed: "favs", heroTag: "favs", toolTip: "See only favourites", icon: const Icon(Icons.favorite)),
          ],
          colorStartAnimation: mPrimaryColor,
          colorEndAnimation: Colors.red.shade900,
          animatedIconData: AnimatedIcons.menu_close //To principal button
      ),
    ),
  ];


  Set<Marker> buildChargerMarkers(BuildContext context, int filter) {
    chargePoints = {};
    favChargePoints = {};
    List<Coordenada> coordsChargers = <Coordenada>[];
    switch(filter){
      case 1: //todos los cargadores
        coordsChargers = ctrlPresentation.getChargePointList();
        break;
      case 2://sólo favoritos
        coordsChargers = ctrlPresentation.getFavsChargerPoints();
        break;
      default:
        coordsChargers = ctrlPresentation.getChargePointList();
        break;
    }
    for (var i = 0; i < coordsChargers.length; ++i) {
      if(filter == 1) {
        chargePoints.add(
          buildChargerMarker(
            index: i,
            lat: coordsChargers[i].latitud,
            long: coordsChargers[i].longitud,
            context: context,
          )
      );
      } else {
        favChargePoints.add(
          buildChargerMarker(
            index: i,
            lat: coordsChargers[i].latitud,
            long: coordsChargers[i].longitud,
            context: context,
          )
      );
      }
    }
    setState(() {});
    if(filter == 2) return favChargePoints;
    return chargePoints;
  }

  Set<Marker> buildBicingMarkers(BuildContext context, int filter) {
    bicingPoints = {};
    favBicingPoints = {};
    List<Coordenada> coordsBicing = <Coordenada>[];
    switch(filter){
      case 1: //todos los cargadores
        print("estoy entrando a cargar todos los bicings!!!!!!!\n");
        coordsBicing = ctrlPresentation.getBicingPointList();
        break;
      case 2://sólo favoritos
        coordsBicing = ctrlPresentation.getFavsBicingPoints();
        break;
      default:
        coordsBicing = ctrlPresentation.getBicingPointList();
        break;
    }

    for (var i = 0; i < coordsBicing.length; ++i) {
      if(filter == 1) {
        bicingPoints.add(
          buildBicingMarker(
            lat: coordsBicing[i].latitud,
            long: coordsBicing[i].longitud,
            context: context,
          )
      );
      } else {
        favBicingPoints.add(
          buildBicingMarker(
            lat: coordsBicing[i].latitud,
            long: coordsBicing[i].longitud,
            context: context,
          )
      );
      }
    }
    setState(() {});
    if(filter == 2) return favBicingPoints;
    return bicingPoints;
  }
}

Marker buildChargerMarker({
  required int index,
  required double lat,
  required double long,
  required BuildContext context,
}){
  return Marker(
    GeoCoord(lat, long),
    icon: "assets/images/me.png",
    onTap: (markerId)=>showInfoCharger(context, lat, long),
  );
}

showInfoCharger(BuildContext context, double lat, double long) {
  List<String> infoChargerPoint = ctrlPresentation.getInfoCharger(lat, long);
  //print(infoChargerPoint);
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
    onTap: (markerId) =>showInfoBicing(context, lat, long, infoBicingPoint)
  );
}

showInfoBicing(BuildContext context, double lat, double long, List<String> infoBicingPoint) {
  return showModalBottomSheet(
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
                    latitud: lat,
                    longitud: long,
                  ),
                ],
              ),
            ),
          ],
        );
      });
}