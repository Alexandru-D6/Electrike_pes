import 'package:flutter/material.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
    List<String> titlesChargers = ctrlPresentation.getNomsFavsChargerPoints();

    return ListView.separated(
        itemCount: titlesChargers.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          Coordenada word = chargerPoints[index];
          String title = titlesChargers[index];

          return ListTile(
            title: Text(title),
            trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                            icon: (const Icon(Icons.bar_chart)),
                            color: Colors.green,
                            onPressed: () {
                              ctrlPresentation.toChartPage(context, title);
                            }
                        ),
                          IconButton(
                              icon: (const Icon(Icons.notification_add)),
                              color: Colors.blue,
                              onPressed: () {
                              ctrlPresentation.showInstantNotification(word.latitud, word.longitud);
                              }
                          ),
                        IconButton(
                            icon: (const Icon(Icons.settings)),
                            color: Colors.grey,
                            onPressed: () {
                              ctrlPresentation.removeShceduledNotification(word.latitud, word.longitud);
                              //ctrlPresentation.showInstantNotification(word.latitud, word.longitud);
                            }
                        ),
                        IconButton(
                            icon: (const Icon(Icons.favorite)),
                            color: Colors.red,
                            onPressed: () {
                              chargerPoints.remove(word);
                              ctrlPresentation.loveClicked(context, word.latitud, word.longitud);
                              Future.delayed(const Duration(milliseconds: 200), () { setState(() {});  });
                            }
                        ),

              ],
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

    List<String> titlesBicing = ctrlPresentation.getNomsFavsBicingPoints();
    return ListView.separated(
      itemCount: titlesBicing.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        Coordenada word = bicingPoints[index];
        String title = titlesBicing[index];


        return ListTile(
          title: Text(title),
          trailing: IconButton(
              icon: (const Icon(Icons.favorite)),
              color: Colors.red,
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
    List<String> titlesChargers = ctrlPresentation.getNomsFavsChargerPoints();

    List<Coordenada> bicingPoints = ctrlPresentation.getFavsBicingPoints();
    List<String> titlesBicings = ctrlPresentation.getNomsFavsBicingPoints();

    List<Coordenada> allFavPoints = chargerPoints + bicingPoints;
    List<String> titles = titlesChargers+titlesBicings;

    return ListView.separated(
      itemCount: titles.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        Coordenada word = allFavPoints[index];
        String title = titles[index];

        return ListTile(
          title: Text(title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  icon: (const Icon(Icons.bar_chart)),
                  color: Colors.green,
                  onPressed: () {
                    ctrlPresentation.toChartPage(context, title);
                  }
              ),
              IconButton(
                  icon: (const Icon(Icons.notification_add)),
                  color: Colors.blue,
                  onPressed: () {
                    ctrlPresentation.showInstantNotification(word.latitud, word.longitud);
                  }
              ),
              IconButton(
                  icon: (const Icon(Icons.settings)),
                  color: Colors.grey,
                  onPressed: () {
                    ctrlPresentation.toTimePicker(context);
                  }
              ),
              IconButton(
                  icon: (const Icon(Icons.favorite)),
                  color: Colors.red,
                  onPressed: () {
                    chargerPoints.remove(word);
                    ctrlPresentation.loveClicked(context, word.latitud, word.longitud);
                    Future.delayed(const Duration(milliseconds: 200), () { setState(() {});  });
                  }
              ),
            ],
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
    AllFavs(),
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
        title: Text(AppLocalizations.of(context).favourites),
        backgroundColor: mPrimaryColor,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_sharp),
            label: AppLocalizations.of(context).allFavourites,
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.electrical_services),
            label: AppLocalizations.of(context).chargers,
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.pedal_bike),
            label: AppLocalizations.of(context).bicing,
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
