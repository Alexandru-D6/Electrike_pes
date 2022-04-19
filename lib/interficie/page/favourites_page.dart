import 'package:flutter/material.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/generated/l10n.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';


class FavsChargers extends StatefulWidget {
  const FavsChargers({Key? key}) : super(key: key);

  @override
  State<FavsChargers> createState() => _FavsChargersState();
}

class _FavsChargersState extends State<FavsChargers> {
  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    List<Coordenada> chargerPoints = ctrlPresentation.getFavsChargerPoints();
    return ListView.separated(
        itemCount: chargerPoints.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          Coordenada word = chargerPoints[index];

          return ListTile(
            title: Text(ctrlPresentation.getInfoCharger(word.latitud, word.longitud)[1]),
            trailing: IconButton(
              icon: (const Icon(Icons.favorite)),
              color: Colors.red,
              onPressed: () {
                chargerPoints.remove(word);
                ctrlPresentation.loveClicked(context, word.latitud, word.longitud);
                Future.delayed(const Duration(milliseconds: 200), () { setState(() {});  });
                }
            ),
            onTap: () {
                ctrlPresentation.moveCameraToSpecificLocation(context, word.latitud, word.longitud);
            },
          );
        },
    );
  }
}

class FavsBicings extends StatefulWidget {
  const FavsBicings({
    Key? key,
    required this.titlesBicing,
    required this.bicingPoints,
  }) : super(key: key);


  final List<String> titlesBicing;
  final List<Coordenada> bicingPoints;

  @override
  State<FavsBicings> createState() => _FavsBicingsState();
}

class _FavsBicingsState extends State<FavsBicings> {

  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();

    return ListView.separated(
      itemCount: widget.titlesBicing.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        Coordenada word = widget.bicingPoints[index];
        String title = widget.titlesBicing[index]; //todo: bicing name call

        return ListTile(
          title: Text(title),
          trailing: IconButton(
              icon: (const Icon(Icons.favorite)),
              color: Colors.red,
              onPressed: () {
                widget.bicingPoints.remove(word);
                ctrlPresentation.loveClicked(context, word.latitud, word.longitud);
                Future.delayed(const Duration(milliseconds: 200), () { setState(() {});  });
              }
          ),
          onTap: () {
            ctrlPresentation.moveCameraToSpecificLocation(context, word.latitud, word.longitud);
          },
        );
      },
    );
  }
}

class AllFavs extends StatefulWidget {
  const AllFavs({Key? key}) : super(key: key);

  @override
  State<AllFavs> createState() => _AllFavsState();
}

class _AllFavsState extends State<AllFavs> {
  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    List<Coordenada> chargerPoints = ctrlPresentation.getFavsChargerPoints();
    List<Coordenada> bicingPoints = ctrlPresentation.getFavsBicingPoints();
    List<Coordenada> allFavPoints = chargerPoints + bicingPoints;
    return ListView.separated(
      itemCount: allFavPoints.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        Coordenada word = allFavPoints[index];

        return ListTile(
          title: Text("ctrlPresentation.getInfoCharger(word.latitud, word.longitud)[1]"),
          trailing: IconButton(
              icon: (const Icon(Icons.favorite)),
              color: Colors.red,
              onPressed: () {
                chargerPoints.remove(word);
                ctrlPresentation.loveClicked(context, word.latitud, word.longitud);
                Future.delayed(const Duration(milliseconds: 200), () { setState(() {});  });
              }
          ),
          onTap: () {
            ctrlPresentation.moveCameraToSpecificLocation(context, word.latitud, word.longitud);
          },
        );
      },
    );
  }
}

class FilterFavsItems extends StatefulWidget {
  const FilterFavsItems({Key? key}) : super(key: key);

  @override
  State<FilterFavsItems> createState() => _FilterFavsItemsState();
}

class _FilterFavsItemsState extends State<FilterFavsItems> {
  List<String> titlesBicing = <String>["a"];
  List<Coordenada> bicingPoints = <Coordenada>[Coordenada(2.0, 2.0)];
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    //AllFavs(), //todo: replicar con bicings y conectar
    FavsChargers(),
    FavsChargers(),
    FavsBicings(titlesBicing: titlesBicing, bicingPoints: bicingPoints),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index == 2 ){
        bicingPoints = ctrlPresentation.getFavsBicingPoints();
        ctrlPresentation.getAllNamesBicing(bicingPoints).then((element){
          titlesBicing = element;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text("Favourites"),
        backgroundColor: mPrimaryColor,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_sharp),
            label: S.of(context).allFavourites,
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.electrical_services),
            label: S.of(context).chargers,
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.pedal_bike),
            label: S.of(context).bicing,
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
