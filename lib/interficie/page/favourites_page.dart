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
          bool isSaved = ctrlPresentation.isAFavPoint(word.latitud, word.longitud);

          return ListTile(
            title: Text(ctrlPresentation.getInfoCharger(word.latitud, word.longitud)[1]),
            trailing: IconButton(
              icon: (const Icon(Icons.favorite)),
              color: isSaved ? Colors.red : null,
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
  const FavsBicings({Key? key}) : super(key: key);

  @override
  State<FavsBicings> createState() => _FavsBicingsState();
}

class _FavsBicingsState extends State<FavsBicings> {
  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    List<Coordenada> bicingPoints = ctrlPresentation.getFavsBicingPoints();
    return ListView.separated(
      itemCount: bicingPoints.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        Coordenada word = bicingPoints[index];
        bool isSaved = ctrlPresentation.isAFavPoint(word.latitud, word.longitud);
        String title = "";
        ctrlPresentation.getInfoBicing(word.latitud, word.longitud).then((element){
          title = element[0];
        });

        return ListTile(
          title: Text(title),
          trailing: IconButton(
              icon: (const Icon(Icons.favorite)),
              color: isSaved ? Colors.red : null,
              onPressed: () {
                bicingPoints.remove(word);
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
    return ListView.separated(
      itemCount: chargerPoints.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        Coordenada word = chargerPoints[index];
        bool isSaved = ctrlPresentation.isAFavPoint(word.latitud, word.longitud);

        return ListTile(
          title: Text(ctrlPresentation.getInfoCharger(word.latitud, word.longitud)[1]),
          trailing: IconButton(
              icon: (const Icon(Icons.favorite)),
              color: isSaved ? Colors.red : null,
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
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    AllFavs(), //todo: replicar con bicings y conectar
    FavsChargers(),
    FavsBicings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
