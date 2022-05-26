import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
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
  List<List<String>> points = [];
  bool charging = true;
  @override
  void initState() {
    ctrlPresentation.getFAVChargers().then((element){
      setState(() {
        points = element;
        charging = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    if(charging) {
      return const CircularProgressIndicator(color: Colors.black26);
    }
    else {
      return ListView.separated(
        itemCount: points.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          Coordenada word = Coordenada(
              double.parse(points[index][0]), double.parse(points[index][1]));
          String title = points[index][2];

          bool hasNotifications = ctrlPresentation.hasNotifications(
              word.latitud, word.longitud);
          bool notificationsOn = ctrlPresentation.notificationsOn(
              word.latitud, word.longitud);

          bool esBarcelona = ctrlPresentation.esBarcelona(
              word.latitud, word.longitud);

          return ListTile(
            title: Text(title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    tooltip: AppLocalizations.of(context).occupancychart,
                    icon: (const Icon(Icons.bar_chart)),
                    color: esBarcelona ? Colors.green : Colors.black12,
                    onPressed: () async {
                      if (esBarcelona) {
                        await ctrlPresentation.getOcupationCharger(
                            word.latitud, word.longitud);
                        ctrlPresentation.toChartPage(context, title);
                      }
                      else {
                        ctrlPresentation.showDialogNotFromBcn(context);
                      }
                    }
                ),

                IconButton(
                    tooltip: AppLocalizations.of(context).notiEnableDis,
                    color: hasNotifications ? Colors.blue : Colors.black12,
                    icon: notificationsOn ?
                    (const Icon(Icons.notifications_active)) :
                    (const Icon(Icons.notifications_off)),
                    onPressed: () {
                      if (!hasNotifications && esBarcelona) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.INFO,
                          animType: AnimType.BOTTOMSLIDE,
                          title: AppLocalizations.of(context).addAlert,

                          desc: AppLocalizations.of(context).addalertdesc,

                          btnOkText: "OK",
                          btnOkOnPress: () {},
                          headerAnimationLoop: false,
                        ).show();
                      }
                      else if (!esBarcelona) {
                        ctrlPresentation.showDialogNotFromBcn(context);
                      }

                      if (notificationsOn) {
                        ctrlPresentation.disableAllNotifications(
                            word.latitud, word.longitud);
                      }
                      else {
                        ctrlPresentation.enableAllNotifications(
                            word.latitud, word.longitud);
                      }
                      setState(() {
                        notificationsOn = ctrlPresentation.notificationsOn(
                            word.latitud, word.longitud);
                      });
                    }
                ),

                IconButton(
                    tooltip: AppLocalizations.of(context).confnoti,
                    icon: (const Icon(Icons.settings)),
                    color: esBarcelona ? Colors.grey : Colors.black12,
                    onPressed: () {
                      if (esBarcelona) {
                        List<List<String>> notifications = ctrlPresentation
                            .getNotifications(word.latitud, word.longitud);
                        ctrlPresentation.toNotificationsPage(
                            context, word.latitud, word.longitud, title);
                      }
                      else {
                        ctrlPresentation.showDialogNotFromBcn(context);
                      }
                    }
                ),
                IconButton(
                    tooltip: AppLocalizations.of(context).addFavPoints,
                    icon: (const Icon(Icons.favorite)),
                    color: Colors.red,
                    onPressed: () {
                      points.removeAt(index);
                      ctrlPresentation.loveClickedCharger(
                          context, word.latitud, word.longitud);
                      setState(() {
                        //initState();
                      });
                    }
                ),
              ],
            ),
            onTap: () {
              ctrlPresentation.moveCameraToSpecificLocation(
                  context, word.latitud, word.longitud);
            },
          );
        },
      );
    }
  }
}

class FavsBicings extends StatefulWidget {
  const FavsBicings({Key? key}) : super(key: key);

  @override
  State<FavsBicings> createState() => _FavsBicingsState();
}

class _FavsBicingsState extends State<FavsBicings> {
  List<List<String>> points = [];
  bool charging = true;

  @override
  void initState() {
    ctrlPresentation.getFAVBicing().then((element){
      setState(() {
        points = element;
        charging = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    if(charging) {
      return const CircularProgressIndicator(color: Colors.black26);
    } else {
      return ListView.separated(
      itemCount: points.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        Coordenada word = Coordenada(double.parse(points[index][0]), double.parse(points[index][1]));
        String title = points[index][2];


        return ListTile(
          title: Text(title),
          trailing: IconButton(
              tooltip: AppLocalizations.of(context).addFavPoints,
              icon: (const Icon(Icons.favorite)),
              color: Colors.red,
              onPressed: () {
                points.removeAt(index);
                ctrlPresentation.loveClickedBicing(context, word.latitud, word.longitud);
                setState(() {

                });
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
}

class FilterFavsItems extends StatefulWidget {
  const FilterFavsItems({Key? key}) : super(key: key);

  @override
  State<FilterFavsItems> createState() => _FilterFavsItemsState();
}

class _FilterFavsItemsState extends State<FilterFavsItems> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    FavsChargers(),
    FavsBicings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: mPrimaryColor,
      elevation: 0,
      title: Text(AppLocalizations.of(context).favourites),
      actions: [
        IconButton(
          tooltip: AppLocalizations.of(context).legend,
          icon: const Icon(
            Icons.info,
            color: Colors.white,
          ),
          onPressed: (){
            ctrlPresentation.showLegendDialog(context, "favsPage");
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: buildAppBar(context),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.electrical_services),
            label: AppLocalizations.of(context).chargers,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.pedal_bike),
            label: AppLocalizations.of(context).bicing,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}