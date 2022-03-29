import 'package:flutter/material.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';


class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    List<Coordenada> chargerPoints = ctrlPresentation.getFavsPoints();
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text("Favourites"),
        backgroundColor: mPrimaryColor,
      ),
      body: ListView.separated(
        itemCount: chargerPoints.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          Coordenada word = chargerPoints[index];

          return ListTile(
            title: Text(ctrlPresentation.getInfoCharger(word.latitud, word.longitud)[1]),
            trailing: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onTap: () {
              setState(() {
                ctrlPresentation.loveClicked(word.latitud, word.longitud);
                ctrlPresentation.getFavsPoints();
              });
            },
          );
        },
      ),
    );
  }
}