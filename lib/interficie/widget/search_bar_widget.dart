import 'package:flutter/material.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:google_place/google_place.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';


class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  _SearchBarWidget createState() =>_SearchBarWidget();
}

class _SearchBarWidget extends State<SearchBarWidget> {
  List<String?> recomendations = <String?>[];
  CtrlPresentation ctrlPresentation = CtrlPresentation();

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Stack(children: <Widget>[
      FloatingSearchBar(
        hint: ctrlPresentation.actualLocation,
        margins: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        scrollPadding: const EdgeInsets.only(top: 60, bottom: 56),
        transitionDuration: const Duration(milliseconds: 500),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        debounceDelay: const Duration(milliseconds: 200),
        automaticallyImplyDrawerHamburger: false,
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
              icon: const Icon(Icons.place),
              onPressed: () {
                setState(() {});
                ctrlPresentation.actualLocation = "Your location";
                ctrlPresentation.moveCameraToLocation();
                //TODO: para la location quiza
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
      hint: ctrlPresentation.destination,
      margins: const EdgeInsets.fromLTRB(10, 60, 10, 0),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      debounceDelay: const Duration(milliseconds: 200),
      automaticallyImplyDrawerHamburger: false,
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
            icon: const Icon(Icons.place),
            onPressed: () {
              ctrlPresentation.moveCameraToLocation();
              //TODO: para la location quiza
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
            elevation: 4.0,
            child: buildRecomendationButtons(text: recomendations, origin: "false"),
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
    required String origin
  }) {
    List<ListTile> list = <ListTile>[];
    for (var element in text) {
      list.add(ListTile(
        title: Text(element!, style: const TextStyle(fontSize: 18, color: Colors.black)),
        onTap: () => {
          setState((){}), //para que ponga el nombre en el hint
          if(origin == "false"){
            ctrlPresentation.destination = element,
          }
          else
            {
              ctrlPresentation.actualLocation = element,
            }
          //ctrlPresentation.makeRoute()
          },//TODO: llamar aqui que hacer con cada boton de la lista
      ));
    }
    return FloatingSearchBarScrollNotifier(child: Column(children: list));

  }

}