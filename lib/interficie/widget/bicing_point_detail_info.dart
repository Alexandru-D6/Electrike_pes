import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/google_map.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class BicingPointDetailInformation extends StatelessWidget {
  const BicingPointDetailInformation({
    Key? key,
    required this.longitud,
    required this.latitud,
  }) : super(key: key);

  //final BicingPoint point;
  final double longitud;
  final double latitud;


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
                      ctrlPresentation.showLegendDialog(context, "bicingPoint");
                    },
                    icon: const Icon(
                      Icons.info,
                    ),
                    tooltip: AppLocalizations.of(context).legend,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  EditInfoPoint(latitude: latitud, longitude: longitud,),
                ],
              ),
            ],
          ),
          const Divider(
            height: 16,
            color: Colors.black54,
          ),
          StatefulPointInfo(latitude: latitud, longitude: longitud,),
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
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StatefulFavouriteButton(latitude: widget.latitude, longitude: widget.longitude,),
        IconButton(
          tooltip: AppLocalizations.of(context).share,
          onPressed: () async {
            String url = await ctrlPresentation.share(latitude: widget.latitude, longitude: widget.longitude, type: "bicing");
            await Clipboard.setData(ClipboardData(text: url));

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Added to clipboard the tapped point!"),
            ));
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
          tooltip: AppLocalizations.of(context).addFavPoints, //TODO (Peilin) ready for test
          onPressed: () {
            ctrlPresentation.loveClickedBicing(context, widget.latitude, widget.longitude);
            if(ctrlPresentation.isAFavPoint(widget.latitude, widget.longitude)) {
              GoogleMap.of(ctrlPresentation.getMapKey())?.removeMarker(GeoCoord(widget.latitude, widget.longitude), group: "favBicingPoints");
            }
            else {
              GoogleMap.of(ctrlPresentation.getMapKey())?.addMarker(
                  const MyMap().markerBicing(
                      context, widget.latitude, widget.longitude), group: "favBicingPoints");
            }
            Future.delayed(const Duration(milliseconds: 200), () { setState(() {});  });
          },
        ),
      ],
    );
  }
}

class StatefulPointInfo extends StatefulWidget {
  const StatefulPointInfo({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  final double latitude;
  final double longitude;

  @override
  State<StatefulPointInfo> createState() => _StatefulPointInfoState();
}

class _StatefulPointInfoState extends State<StatefulPointInfo> {
  List<String> infoBicingPoint = List.filled(21, "");
  bool loading = true;
  @override
  void initState() { //todo: crear el build de tal manera que haya un tiempo de carga hasta que se reciba la respuesta de la API.
    ctrlPresentation.getInfoBicing(widget.latitude, widget.longitude).then((element){
      setState(() {
        infoBicingPoint = element;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(loading) {
      return const CircularProgressIndicator(color: Colors.black26);
    }
    else {
      return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Icon(Icons.pedal_bike, color: Colors.white, size: 45,),
          title: AutoSizeText(
            infoBicingPoint[0],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildBicingPointInfo(
                num: infoBicingPoint[5],
                assetName: Icons.local_parking),
            buildBicingPointInfo(
                num: infoBicingPoint[3],
                assetName: Icons.pedal_bike),
            buildBicingPointInfo(
                num: infoBicingPoint[4],
                assetName: Icons.electric_bike),
          ],
        )
      ],
    );
    }
  }
}

Widget buildBicingPointInfo({
  required String num,
  required IconData assetName,
}) {
  return Column(
    children: <Widget>[
      Icon(assetName, size: 45, color: mCardColor),
      AutoSizeText(
        num,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      ),
    ],
  );
}