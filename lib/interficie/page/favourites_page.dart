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
  List<List<String>> points = [["0","0","Chargin..."]];
  @override
  void initState() {
    ctrlPresentation.getFAVChargers().then((element){
      setState(() {
        points = element;
        print(points.length);
        print(points);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();

    return ListView.separated(
      itemCount: points.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        Coordenada word = Coordenada(double.parse(points[index][0]), double.parse(points[index][1]));
        String title = points[index][2];

        bool esBarcelona = ctrlPresentation.esBarcelona(word.latitud, word.longitud);

        return ListTile(
          title: Text(title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if(esBarcelona)IconButton(
                  icon: (const Icon(Icons.bar_chart)),
                  color: Colors.green,
                  onPressed: () async{
                    await ctrlPresentation.getOcupationCharger(word.latitud, word.longitud);
                    ctrlPresentation.toChartPage(context, title);
                  }
              ),
              if(esBarcelona)IconButton(
                  icon: (const Icon(Icons.notification_add)),
                  color: Colors.blue,
                  onPressed: () {
                    ctrlPresentation.showInstantNotification(word.latitud, word.longitud);
                  }
              ),
              if(esBarcelona)IconButton(
                  icon: (const Icon(Icons.settings)),
                  color: Colors.grey,
                  onPressed: () {
                    //ctrlPresentation.showInstantNotification(word.latitud, word.longitud);
                  }
              ),
              if(word.latitud != 0 && word.longitud != 0)IconButton(
                  icon: (const Icon(Icons.favorite)),
                  color: Colors.red,
                  onPressed: () {
                    
                    points.removeAt(index);
                    ctrlPresentation.loveClicked(context, word.latitud, word.longitud);
                    setState(() {});
                  }
              ),

            ],
          ),
          onTap: () {
            if(word.latitud != 0 && word.longitud != 0)ctrlPresentation.moveCameraToSpecificLocation(context, word.latitud, word.longitud);
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
  List<List<String>> points = [["0","0","Charging..."]];
  @override
  void initState() {
    ctrlPresentation.getFAVBicing().then((element){
      setState(() {
        points = element;
        print(points.length);
        print(points);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    return ListView.separated(
      itemCount: points.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        Coordenada word = Coordenada(double.parse(points[index][0]), double.parse(points[index][1]));
        String title = points[index][2];
        if(word.latitud != 0 && word.longitud != 0){
          return ListTile(
            title: Text(title),
            trailing: IconButton(
                icon: (const Icon(Icons.favorite)),
                color: Colors.red,
                onPressed: () {
                  points.removeAt(index);
                  ctrlPresentation.loveClicked(context, word.latitud, word.longitud);
                  setState(() {});
                }
            ),
            onTap: () {
              if(word.latitud != 0 && word.longitud != 0)ctrlPresentation.moveCameraToSpecificLocation(context, word.latitud, word.longitud);
            },
          );
        }
        else{
          return ListTile(
            title: Text(title),
          );
        }
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

    int numChargers = chargerPoints.length;

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
        bool hasNotifications = ctrlPresentation.hasNotifications(word.latitud, word.longitud);
        bool notificationsOn = ctrlPresentation.notificationsOn(word.latitud, word.longitud);

        bool esBarcelona = false;
        if(index < numChargers) {
          esBarcelona = ctrlPresentation.esBarcelona(word.latitud, word.longitud);
        }

        return ListTile(
          title: Text(title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if(esBarcelona) IconButton(
                  icon: (const Icon(Icons.bar_chart)),
                  color: Colors.green,
                  onPressed: () async {
                    await ctrlPresentation.getOcupationCharger(word.latitud, word.longitud);
                    ctrlPresentation.toChartPage(context, title);
                  }
              ),
              IconButton(
                  color: hasNotifications ? Colors.blue : Colors.black12,
                  icon: notificationsOn ?
                  (const Icon(Icons.notifications_active)) :
                  (const Icon(Icons.notifications_off)),
                  onPressed: () {
                    if(!hasNotifications){
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
                  color: Colors.grey,
                  onPressed: () {
                    List<List<String>> notifications = ctrlPresentation.getNotifications(word.latitud, word.longitud);
                    ctrlPresentation.toNotificationsPage(context, word.latitud, word.longitud, title);
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