import 'package:flutter/material.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/google_map.dart';
import 'package:google_place/google_place.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  _SearchBarWidget createState() =>_SearchBarWidget();
}

class _SearchBarWidget extends State<SearchBarWidget> {
  List<String?> recomendations = <String?>[];
  CtrlPresentation ctrlPresentation = CtrlPresentation();

  late FloatingSearchBarController controller;
  late FloatingSearchBarController controller2;

  @override
  void initState(){
    super.initState();
    controller = FloatingSearchBarController();
    controller2 = FloatingSearchBarController();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Stack(children: <Widget>[
      FloatingSearchBar(
        controller: controller2,
        hint: ctrlPresentation.actualLocation,
        margins: const EdgeInsets.fromLTRB(60, 5, 60, 0),
        scrollPadding: const EdgeInsets.only(top: 60, bottom: 56),
        transitionDuration: const Duration(milliseconds: 300),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        debounceDelay: const Duration(milliseconds: 100),
        automaticallyImplyDrawerHamburger: false,
        automaticallyImplyBackButton: false,
        onQueryChanged: (query) {
          updateRecomendations(query);
        },
        // Specify a custom transition to be used for
        // animating between opened and closed stated.
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              tooltip:  AppLocalizations.of(context).yourLocation,
              icon: const Icon(Icons.place),
              onPressed: () {
                setState(() {});
                ctrlPresentation.actualLocation = "My location";
                ctrlPresentation.moveCameraToLocation();
                },
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 5.0,
              child: buildRecomendationButtons(text: recomendations, origin: "true"),
            ),
          );
        },
      ),
        FloatingSearchBar(
          controller: controller,
      hint: ctrlPresentation.destination,
      margins: const EdgeInsets.fromLTRB(60, 60, 60, 0),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      debounceDelay: const Duration(milliseconds: 100),
      automaticallyImplyDrawerHamburger: false,
      closeOnBackdropTap: true,
      automaticallyImplyBackButton: false,
      onQueryChanged: (query) {
        updateRecomendations(query);
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: (ctrlPresentation.destination != "Search...") ? CircularButton(
            tooltip: AppLocalizations.of(context).searchroute,
            icon: const Icon(Icons.directions),
            onPressed: () {
              showInfoRuta(context);
              ctrlPresentation.clearAllRoutes();
            },
          ) : Container(),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [buildRecomendationButtons(text: recomendations, origin: "false")],
            ),
          ),
        );
      },
    ),
    ],
    );
  }

  void updateRecomendations(String? query) {
    if (query != "") {
      getPlaceService.autoCompleteAdress(query!, 40.3243, 2.4353).then((element) {
        if (element != null) {
          recomendations.clear();
          setState(() {
            List<AutocompletePrediction>? temp = element.predictions;
            if (temp != null) {
              for (var e in temp) {
                recomendations.add(e.description);
              }
            }
          });
        }
      });
    }
  }

  Widget buildRecomendationButtons({
    required List<String?> text,
    required String origin,
  }) {
    List<ListTile> list = <ListTile>[];
    for (var element in text) {
      list.add(ListTile(
        title: Text(element!, style: const TextStyle(fontSize: 18, color: Colors.black)),
        onTap: () {
          setState((){}); //para que ponga el nombre en el hint
          if(origin == "false"){
            ctrlPresentation.destination = element;
            controller.close();
          }else {
            ctrlPresentation.actualLocation = element;
            controller2.close();
          }


          //ctrlPresentation.toMainPage(context),
          //ctrlPresentation.makeRoute()
          },
      ));
    }
    return FloatingSearchBarScrollNotifier(child: Column(mainAxisSize: MainAxisSize.min, children: list));

  }

}