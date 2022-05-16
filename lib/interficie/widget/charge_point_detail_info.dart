import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/google_map.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
//import 'package:flutter_project/libraries/flutter_google_maps/src/core/google_map.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChargePointDetailInformation extends StatelessWidget {
  const ChargePointDetailInformation({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: mPrimaryColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      ctrlPresentation.showLegendDialog(context, "chargePoint");
                    },
                    icon: const Icon(
                      Icons.info,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  EditInfoPoint(latitude: latitude, longitude: longitude,),
                ],
              ),
            ],
          ),
          const Divider(
            height: 16,
            color: Colors.black54,
          ),
          PointInfo(latitude: latitude, longitude: longitude,),
        ],
      ),
    );
  }
}

class EditInfoPoint extends StatefulWidget {
  const EditInfoPoint({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  final double latitude;
  final double longitude;

  @override
  State<EditInfoPoint> createState() => _EditInfoPointState();
}

class _EditInfoPointState extends State<EditInfoPoint> {
  List<String> point = List.filled(23, "");
  @override
  void initState() { //todo: crear el build de tal manera que haya un tiempo de carga hasta que se reciba la respuesta de la API.
    ctrlPresentation.getInfoCharger(widget.latitude, widget.longitude).then((element){
      setState(() {
        point = element;
        print(point[22]);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StatefulFavouriteButton(latitude: widget.latitude, longitude: widget.longitude,),
        if(point[22] == "false") IconButton(
          onPressed: () async {
          await ctrlPresentation.getOcupationCharger(widget.latitude, widget.longitude);
          ctrlPresentation.getInfoCharger(widget.latitude, widget.longitude).then((element){
            ctrlPresentation.toChartPage(context, element[1]);
          });
          },
          icon: const Icon(
            Icons.bar_chart,
          ),
        ),
        IconButton(
          onPressed: () {
            ctrlPresentation.share(latitude: widget.latitude, longitude: widget.longitude);
          },
          icon: const Icon(
            Icons.share,
          ),
        ),
      ],
    );
  }
}

class StatefulFavouriteButton extends StatefulWidget {
  const StatefulFavouriteButton({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  final double latitude;
  final double longitude;

  @override
  State<StatefulFavouriteButton> createState() => _StatefulFavouriteButtonState();
}

CtrlPresentation ctrlPresentation = CtrlPresentation();

class _StatefulFavouriteButtonState extends State<StatefulFavouriteButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(
            ctrlPresentation.isAFavPoint(widget.latitude, widget.longitude) ? Icons.favorite : Icons.favorite_border,
            color: ctrlPresentation.isAFavPoint(widget.latitude, widget.longitude) ? Colors.red : null,
          ),
          tooltip: AppLocalizations.of(context).msgAddFav,
          onPressed: () {
              ctrlPresentation.loveClicked(context, widget.latitude, widget.longitude);
              if(ctrlPresentation.isAFavPoint(widget.latitude, widget.longitude)) {
                GoogleMap.of(ctrlPresentation.getMapKey())?.removeMarker(GeoCoord(widget.latitude, widget.longitude), group: "favChargerPoints");
              }
              else {
                GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(
                  const MyMap().markerCharger(
                      context, widget.latitude, widget.longitude), group: "favChargerPoints");
              }
              Future.delayed(const Duration(milliseconds: 200), () { setState(() {});  });
          },
        ),
      ],
    );
  }
}

class PointInfo extends StatefulWidget {
  const PointInfo({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  final double latitude;
  final double longitude;

  @override
  State<PointInfo> createState() => _PointInfoState();
}

class _PointInfoState extends State<PointInfo> {
  List<String> point = List.filled(23, ""); //si da error de size aumentar 1

  @override
  void initState() { //todo: crear el build de tal manera que haya un tiempo de carga hasta que se reciba la respuesta de la API.
    ctrlPresentation.getInfoCharger(widget.latitude, widget.longitude).then((element){
      setState(() {
        point = element;
      });
    });
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => {});
  }

  @override
  Widget build(BuildContext context) {
    Column res = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        buildHeader(
          name: point[1],
          calle: point[2],
          city: point[3],
          numChargePlaces: point[4],
          context: context,
        ),
        buildConnectors(point),
      ],
    );

    return res;
  }

  Widget buildHeader({
    required String name,
    required String calle,
    required String city,
    required String numChargePlaces,
    required BuildContext context,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(Icons.ev_station, size: 60, color: Colors.white,),
      const SizedBox(width: 6),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
            AutoSizeText(
              calle,
              style: const TextStyle(
                color: Colors.white,
              ),
              maxLines: 1,
            ),
            AutoSizeText(
              city,
              style: const TextStyle(
                color: Colors.white,
              ),
              maxLines: 1,
            ),

            Row(
              children: [
                AutoSizeText(
                  numChargePlaces.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
                const Icon(
                  Icons.local_parking,
                  color: Colors.white,
                ),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    ],
  );

  Widget buildConnectors(List<String> point) => ResponsiveGridRow(
    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ResponsiveGridCol(
        xs: 6,
        md: 3,
        child: buildConnectorInfo(
          numAvailable: point[5],
          numUnknownState: point[6],
          numCrashedState: point[7],
          numNotAvailable: point[8],
          logoConnector: "assets/images/Schuko.png",
          nameConnector: "Schuko",
        ),
      ),
      ResponsiveGridCol(
        xs: 6,
        md: 3,
        child: buildConnectorInfo(
          numAvailable: point[9],
          numUnknownState: point[10],
          numCrashedState: point[11],
          numNotAvailable: point[12],
          logoConnector: "assets/images/Mennekes.png",
          nameConnector: "Mennekes (Type 2)",
        ),
      ),
      ResponsiveGridCol(
        xs: 6,
        md: 3,
        child: buildConnectorInfo(
          numAvailable: point[13],
          numUnknownState: point[14],
          numCrashedState: point[15],
          numNotAvailable: point[16],
          logoConnector: "assets/images/CHAdeMO.png",
          nameConnector: " CHAdeMO (DC)",
        ),
      ),
      ResponsiveGridCol(
        xs: 6,
        md: 3,
        child: buildConnectorInfo(
          numAvailable: point[17],
          numUnknownState: point[18],
          numCrashedState: point[19],
          numNotAvailable: point[20],
          logoConnector: "assets/images/ComboCCS2.png",
          nameConnector: "CCS Combo (DC)",
        ),
      ),
    ],
  );
}


Widget buildConnectorInfo({
  required String numAvailable,
  required String numNotAvailable,
  required String numUnknownState,
  required String logoConnector,
  required String nameConnector,
  required String numCrashedState}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        logoConnector,
        height: 50,
      ),
      const SizedBox(width: 10),
      AutoSizeText(
        nameConnector,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      const SizedBox(width: 25),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSummary(
            icon: Icons.check_circle_rounded,
            color: Colors.greenAccent,
            info: numAvailable,
          ),
          const SizedBox(width: 10),
          buildSummary(
            icon: Icons.help,
            color: Colors.yellow,
            info: numUnknownState,
          ),
          const SizedBox(width: 10),
          buildSummary(
            icon: Icons.warning,
            color: Colors.amber,
            info: numCrashedState,
          ),
          const SizedBox(width: 10),
          buildSummary(
            icon: Icons.stop_circle,
            color: Colors.red,
            info: numNotAvailable,
          ),
        ],
      ),
    ],
  );
}

buildSummary({
  required IconData icon,
  required Color color,
  required String info,}) {
  return Column(
    children: [
      Icon(icon, color: color,),
      AutoSizeText(
        info,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      ),
    ],
  );
}