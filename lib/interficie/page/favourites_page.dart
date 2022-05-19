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

        bool hasNotifications = ctrlPresentation.hasNotifications(word.latitud, word.longitud);
        bool notificationsOn = ctrlPresentation.notificationsOn(word.latitud, word.longitud);

        bool esBarcelona = ctrlPresentation.esBarcelona(word.latitud, word.longitud);

        return ListTile(
          title: Text(title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: (const Icon(Icons.bar_chart)),
                color: esBarcelona ? Colors.green : Colors.black12,
                onPressed: () async {
                  if(esBarcelona) {
                    await ctrlPresentation.getOcupationCharger(
                        word.latitud, word.longitud);
                    ctrlPresentation.toChartPage(context, title);
                  }
                  else{
                    ctrlPresentation.showDialogNotFromBcn(context);
                  }

                }
              ),

              IconButton(
                  color: hasNotifications ? Colors.blue : Colors.black12,
                  icon: notificationsOn ?
                  (const Icon(Icons.notifications_active)) :
                  (const Icon(Icons.notifications_off)),
                  onPressed: () {
                    if(!hasNotifications && esBarcelona){
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.INFO,
                        animType: AnimType.BOTTOMSLIDE,
                        title: "Add alerts", //TODO: TRANSLATE
                        desc: "You haven't got any alert associated to this point. Add at least one to receive notifications from this point.", //TODO: TRANSLATE
                        btnOkText: "OK",
                        btnOkOnPress: () {},
                        headerAnimationLoop: false,
                      ).show();
                    }
                    else if (!esBarcelona){
                      ctrlPresentation.showDialogNotFromBcn(context);
                    }

                    if(notificationsOn){
                      ctrlPresentation.disableAllNotifications(word.latitud, word.longitud);
                    }
                    else{
                      ctrlPresentation.enableAllNotifications(word.latitud, word.longitud);
                    }
                    setState(() {
                      notificationsOn = ctrlPresentation.notificationsOn(word.latitud, word.longitud);
                    });
                  }
              ),

              IconButton(
                  icon: (const Icon(Icons.settings)),
                  color: esBarcelona ? Colors.grey : Colors.black12,
                  onPressed: () {
                    if(esBarcelona) {
                      List<List<String>> notifications = ctrlPresentation
                          .getNotifications(word.latitud, word.longitud);
                      ctrlPresentation.toNotificationsPage(
                          context, word.latitud, word.longitud, title);
                    }
                    else{
                      ctrlPresentation.showDialogNotFromBcn(context);
                    }
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