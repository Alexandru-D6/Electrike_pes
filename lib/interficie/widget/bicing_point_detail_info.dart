import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';

class BicingPointDetailInformation extends StatelessWidget {
  const BicingPointDetailInformation({
    Key? key,
    required this.name,
    required this.docks,
    required this.bicisE,
    required this.bicisM,
    required this.longitud,
    required this.latitud,
  }) : super(key: key);

  //final BicingPoint point;
  final String name;
  final String docks;
  final String bicisE;
  final String bicisM;
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
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              EditInfoPoint(latitude: latitud, longitude: longitud,),
            ],
          ),
          PointInfo(
            name: name,
            docks: docks,
            bicisE: bicisE,
            bicisM: bicisM,
          ),
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
          onPressed: () {},
          icon: const Icon(
            Icons.share,
          ),//TODO: Share
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
          tooltip: 'Add points to favourites', //todo: translate AppLocalizations.of(context).[]
          onPressed: () {
            ctrlPresentation.loveClicked(context, widget.latitude, widget.longitude);
            Future.delayed(const Duration(milliseconds: 200), () { setState(() {});  });
          },
        ),
      ],
    );
  }
}

class PointInfo extends StatelessWidget {
  const PointInfo({
    Key? key,
    required this.name,
    required this.docks,
    required this.bicisE,
    required this.bicisM,
  }) : super(key: key);

  final String name;
  final String docks;
  final String bicisE;
  final String bicisM;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ListTile(
          leading: const Icon(Icons.pedal_bike, color: Colors.white, size: 45,),
          title: AutoSizeText(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            maxLines: 1,
          ),
        ),
        const Divider(
          height: 16,
          color: Colors.black54,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildBicingPointInfo(
                num: docks,
                assetName: Icons.local_parking),
            buildBicingPointInfo(
                num: bicisM,
                assetName: Icons.pedal_bike),
            buildBicingPointInfo(
                num: bicisE,
                assetName: Icons.electric_bike),
          ],
        )
      ],
    );
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