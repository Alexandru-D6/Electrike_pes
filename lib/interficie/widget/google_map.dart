import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';

Future main() async {
  GoogleMap.init('AIzaSyBN9tjrv5YdkS1K-E1xP9UVLEkSnknU0yY');
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyMap());
}

class MyMap extends StatelessWidget {
  static const String title = 'Electrike';
  const MyMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage()
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<GoogleMapStateBase> _key = GlobalKey<GoogleMapStateBase>();

  GeoCoord lastCoord = const GeoCoord(10.00, 20.00);

  List<Widget> _buildClearButtons() => [
    const SizedBox(width: 16),
    RaisedButton.icon(
      color: Colors.red,
      textColor: Colors.white,
      icon: Icon(Icons.pin_drop),
      label: Text('CLEAR MARKERS'),
      onPressed: () {
        GoogleMap.of(_key).clearMarkers();
      },
    ),
    const SizedBox(width: 16),
    RaisedButton.icon(
      color: Colors.red,
      textColor: Colors.white,
      icon: Icon(Icons.directions),
      label: Text('CLEAR DIRECTIONS'),
      onPressed: () {
        GoogleMap.of(_key).clearDirections();
      },
    ),
  ];

  List<Widget> _buildAddButtons() => [
    const SizedBox(width: 16),
    FloatingActionButton(
      child: Icon(Icons.pin_drop),
      onPressed: () {
        GoogleMap.of(_key).addMarkerRaw(
          lastCoord,
          icon: 'assets/images/estation.png',
          info: 'test info',
          onInfoWindowTap: () async {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(
                    'This dialog was opened by tapping on the InfoWindow!'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: Navigator.of(context).pop,
                    child: Text('CLOSE'),
                  ),
                ],
              ),
            );
          },
        );
        GoogleMap.of(_key).addMarkerRaw(
          GeoCoord(33.775513, -117.450257),
          icon: 'assets/images/map-marker-warehouse.png',
          info: contentString,
        );
      },
    ),
    const SizedBox(width: 16),
    FloatingActionButton(
      child: Icon(Icons.directions),
      onPressed: () {
        //GoogleMap.of(_key).addPolygon(id, points);
        /*
        GoogleMap.of(_key).addDirection(
          const GeoCoord(41.385983, 2.118057),
          const GeoCoord(41.375034, 2.163633),
          startLabel: '1',
          startInfo: 'bbbbbbbb',
          endIcon: 'assets/images/rolls_royce.png',
          endInfo: 'aaaaaa',
        );*/
      },
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    key: _scaffoldKey,
    appBar: AppBar(
      title: Text('Google Map'),
    ),
    body: Stack(
      children: <Widget>[
        Positioned.fill(
          child: GoogleMap(
            key: _key,
            markers: {
              Marker(
                GeoCoord(34.0469058, -118.3503948),
              ),
            },
            initialZoom: 9,
            initialPosition:
            GeoCoord(41.8204600, 1.8676800), // Catalunya
            mapType: MapType.roadmap,
            mapStyle: null,
            interactive: true,
            onTap: (coord) => lastCoord = coord,
            mobilePreferences: const MobileMapPreferences(
              trafficEnabled: true,
              zoomControlsEnabled: false,
            ),
            webPreferences: WebMapPreferences(
              fullscreenControl: true,
              zoomControl: true,
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: FloatingActionButton(
            child: Icon(Icons.person_pin_circle),
            onPressed: () {
              final bounds = GeoCoordBounds(
                northeast: GeoCoord(41.8204600, 1.8676800),
                southwest: GeoCoord(41.8204600, 1.8676800),
              );
              GoogleMap.of(_key).moveCameraBounds(bounds);
              GoogleMap.of(_key).addMarkerRaw(
                GeoCoord(
                  (bounds.northeast.latitude + bounds.southwest.latitude) /
                      2,
                  (bounds.northeast.longitude +
                      bounds.southwest.longitude) /
                      2,
                ),
                onTap: (markerId) async {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(
                        'This dialog was opened by tapping on the marker!\n'
                            'Marker ID is $markerId',
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: Navigator.of(context).pop,
                          child: Text('CLOSE'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
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
              Spacer(),
              ..._buildAddButtons(),
            ],
          ),
        ),
      ],
    ),
  );
}

const darkMapStyle = r'''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]
''';

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
