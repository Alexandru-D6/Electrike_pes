import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/rutes/routes_response.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/libraries/flutter_google_maps/src/core/markers_information.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import '../../domini/services/service_locator.dart';
import 'bicing_point_detail_info.dart';
import 'charge_point_detail_info.dart';
import 'info_ruta.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



CtrlPresentation ctrlPresentation = CtrlPresentation();

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  MyMapState createState() => MyMapState();

  Marker markerCharger(BuildContext context, double latitude, double longitude) {
    return buildChargerMarker(lat: latitude, long: longitude, context: context);
  }

  Marker markerBicing(BuildContext context, double latitude, double longitude) {
    return buildBicingMarker(lat: latitude, long: longitude, context: context);
  }
}

class MyMapState extends State<MyMap> {
  double currentZoom = 11.0;
  GeoCoord lastCoord = const GeoCoord(10.00, 20.00);
  late BuildContext ctx;
  GeoCoord lastPosition = const GeoCoord(0.0,0.0);
  GlobalKey<GoogleMapStateBase> _newKey = GlobalKey<GoogleMapStateBase>();

  Future<void> initMarkers(String? show) async {
    //GoogleMap.of(ctrlPresentation.getMapKey())?.chooseMarkers(group);
    switch(show){
      case "chargers":
        GoogleMap.of(ctrlPresentation.getMapKey())?.clearChoosenMarkers();
        GoogleMap.of(ctrlPresentation.getMapKey())?.addChoosenMarkers("chargerPoints");
        break;
      case "bicing":
        GoogleMap.of(ctrlPresentation.getMapKey())?.clearChoosenMarkers();
        GoogleMap.of(ctrlPresentation.getMapKey())?.addChoosenMarkers("bicingPoints");
        break;
      case "favs":
        if(!(await getLoginService.isSignIn())) {
          ctrlPresentation.showNotLogDialog(context);
        } else {
          GoogleMap.of(ctrlPresentation.getMapKey())?.clearChoosenMarkers();
          buildFavs("favChargerPoints");
          buildFavs("favBicingPoints");
          GoogleMap.of(ctrlPresentation.getMapKey())?.addChoosenMarkers("favChargerPoints");
          GoogleMap.of(ctrlPresentation.getMapKey())?.addChoosenMarkers("favBicingPoints");
        }
        break;
      case "all":
        GoogleMap.of(ctrlPresentation.getMapKey())?.clearChoosenMarkers();
        GoogleMap.of(ctrlPresentation.getMapKey())?.addChoosenMarkers("chargerPoints");
        GoogleMap.of(ctrlPresentation.getMapKey())?.addChoosenMarkers("bicingPoints");
        break;
      default:
        GoogleMap.of(ctrlPresentation.getMapKey())?.clearChoosenMarkers();
        GoogleMap.of(ctrlPresentation.getMapKey())?.addChoosenMarkers("default");
        GoogleMap.of(ctrlPresentation.getMapKey())?.addChoosenMarkers("route");
        break;
    }
  }

  void buildFavs(String group) {
    GoogleMap.of(ctrlPresentation.getMapKey())?.clearGroupMarkers(group);

    if (group != "favBicingPoints") {
      List<Coordenada> coords = ctrlPresentation.getFavsChargerPoints();
      for (var element in coords) {
        GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(buildChargerMarker(lat: element.latitud, long: element.longitud, context: context), group: group);
      }
    } else {
      List<Coordenada> coords = ctrlPresentation.getFavsBicingPoints();
      for (var element in coords) {
        GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(buildBicingMarker(lat: element.latitud, long: element.longitud, context: context), group: group);
      }
    }
  }

  void setStateMod() {
    setState(() {});
  }

  Future<void> chargerMarkers() async {
    buildChargerMarkers(context, 1);
    buildBicingMarkers(context, 1);
    buildChargerMarkers(context, 2);
    buildBicingMarkers(context, 2);
  }

  @override
  Widget build(BuildContext context) {
    if (ctrlPresentation.getGoogleMapKeyState()) {
      _newKey = ctrlPresentation.getMapKey();
    } else {
      _newKey = GlobalKey<GoogleMapStateBase>();
    }

    double tempZoom = 0.0;
    Scaffold res = Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GoogleMap(
              key: _newKey,
              markers: const <Marker>{},
              initialZoom: 9,
              //final isWebMobile = kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android)
              //minZoom: 3,
              initialPosition: const GeoCoord(41.8204600, 1.8676800), // Catalunya
              mapType: MapType.roadmap,
              mapStyle: null,
              interactive: true,

              onLongPress: (pos) async {
                String url = ctrlPresentation.generateUrlForLocation(pos);
                await Clipboard.setData(ClipboardData(text: url));

                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                  content: Text(AppLocalizations.of(context).addedclip),
                ));
              },

              /*onTap: (a) async {
                await GoogleMap.of(ctrlPresentation.getMapKey())?.getZoomCamera().then((value) => tempZoom = value);
                showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                  title: const Text('Zoom level'),
                  content: SingleChildScrollView(
                    child: ListBody(
                    children: <Widget>[
                      Text(tempZoom.toString()),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Approve'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      ),
                    ],
                  );
                },
                );},*/

              mobilePreferences: const MobileMapPreferences(
                myLocationEnabled:true,
                myLocationButtonEnabled: true,
                rotateGesturesEnabled: true,
                compassEnabled: true,
                zoomGesturesEnabled:true,

                trafficEnabled: false,
                zoomControlsEnabled: false,
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
            //left: 16,
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

    return res;
  }

  @override
  void initState() {
    super.initState();
     // ignore: unnecessary_non_null_assertion
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      ctrlPresentation.setMapKey(_newKey);
      chargerMarkers();

    });
  }

  SpeedDialChild button(
      { required String onPressed,
        required String heroTag,
        required String toolTip,
        required Icon icon,
        required Color backgroundColor,
        required Color foregroundColor}) {
    return SpeedDialChild(
      child: icon,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      label: toolTip,
      onPressed: (){
        initMarkers(onPressed); //llamar a funcion de la libreria
      },
    );
  }

  List<Widget> _buildClearButtons() => [
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: SpeedDial(
        child: const Icon(Icons.filter_alt),
        speedDialChildren: <SpeedDialChild>[
          button(onPressed: "default", heroTag: "hide", toolTip: AppLocalizations.of(context).hideMarkers, icon: const Icon(Icons.visibility_off), backgroundColor: Colors.black12, foregroundColor: Colors.white), //(Peilin) ready for test
          button(onPressed: "all", heroTag: "all", toolTip: AppLocalizations.of(context).showMarkers, icon: const Icon(Icons.visibility), backgroundColor: Colors.black12, foregroundColor: Colors.black),
          button(onPressed: "chargers", heroTag: "charger", toolTip: AppLocalizations.of(context).chargers, icon: const Icon(Icons.power), backgroundColor: mCardColor, foregroundColor: Colors.white),
          button(onPressed: "bicing", heroTag: "bicing", toolTip: AppLocalizations.of(context).bicing, icon: const Icon(Icons.pedal_bike), backgroundColor: cBicingRed, foregroundColor: Colors.white),
          button(onPressed: "favs", heroTag: "favs", toolTip: AppLocalizations.of(context).favouritesMark, icon: const Icon(Icons.favorite), backgroundColor: Colors.red, foregroundColor: Colors.white),
        ],
        closedForegroundColor: Colors.black,
        openForegroundColor: Colors.white,
        closedBackgroundColor: Colors.white,
        openBackgroundColor: Colors.black,
      ),
    ),
  ];

  void buildChargerMarkers(BuildContext context, int filter) {
    //GoogleMap.of(ctrlPresentation.getMapKey())
    List<Coordenada> coordsChargers = <Coordenada>[];

    switch(filter){
      case 2://sólo favoritos
        coordsChargers = ctrlPresentation.getFavsChargerPoints();
        break;
      default: //todos los cargadores
        coordsChargers = ctrlPresentation.getChargePointList();
        break;
    }

    for (var i = 0; i < coordsChargers.length; ++i) {
      if(filter == 1) {
        GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(
          buildChargerMarker(
            lat: coordsChargers[i].latitud,
            long: coordsChargers[i].longitud,
            context: context,
          ),
          group: "chargerPoints",
      );
      } else {
        GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(
          buildChargerMarker(
            lat: coordsChargers[i].latitud,
            long: coordsChargers[i].longitud,
            context: context,
          ),
          group: "favChargerPoints",
      );
      }
    }
  }

  void buildBicingMarkers(BuildContext context, int filter) {
    //GoogleMap.of(ctrlPresentation.getMapKey())
    List<Coordenada> coordsBicing = <Coordenada>[];
    switch(filter){
      case 2://sólo favoritos
        coordsBicing = ctrlPresentation.getFavsBicingPoints();
        break;
      default: //todos los cargadores
        coordsBicing = ctrlPresentation.getBicingPointList();
        break;
    }

    for (var i = 0; i < coordsBicing.length; ++i) {
      if(filter == 1) {
        GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(
          buildBicingMarker(
            lat: coordsBicing[i].latitud,
            long: coordsBicing[i].longitud,
            context: context,
          ),
          group: "bicingPoints",
        );
      } else {
        GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(
          buildBicingMarker(
            lat: coordsBicing[i].latitud,
            long: coordsBicing[i].longitud,
            context: context,
          ),
          group: "favBicingPoints",
      );
      }
    }
  }
}

showInfoRuta(BuildContext context) {
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
              children: const [
                InfoRuta(),
              ],
            ),
          ),
        ],
      );
    });
}

Marker buildChargerMarker({
  required double lat,
  required double long,
  required BuildContext context,
}){
  return Marker(
    GeoCoord(lat, long),
    icon: (!kIsWeb) ? "assets/images/me.png" : "assets/images/meWeb.png",
    onTap: (markerId)=>showInfoCharger(context, lat, long),
  );
}

showInfoCharger(BuildContext context, double lat, double long) {
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
                  ChargePointDetailInformation(latitude: lat, longitude: long,),
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
  return Marker(
    GeoCoord(lat, long),
    icon: (!kIsWeb) ? "assets/images/bike.png" : "assets/images/bikeWeb.png",
    onTap: (markerId) =>showInfoBicing(context, lat, long)
  );
}

showInfoBicing(BuildContext context, double lat, double long) {
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
                  BicingPointDetailInformation(latitud: lat, longitud: long),
                ],
              ),
            ),
          ],
        );
      });
}