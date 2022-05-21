import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RewardsPage extends StatelessWidget {
  const RewardsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    List<List<String>> trophies = ctrlPresentation.getTrophies();
    print(trophies);
    return Scaffold(
        drawer: const NavigationDrawerWidget(),
        //esto es para que aparezca el botón de menú lateral
        appBar: AppBar(
          title: const Text('Rewards'), //todo: translate
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ResponsiveGridList(
                desiredItemWidth: 100,
                minSpacing: 40,
                children: [for(var i=0; i<trophies.length; i+=1) i].map((index) {
                  Image img = Image.asset('assets/trophies/lockedtrophy.png', width: 100);
                  Color c = Colors.black54;
                  if(trophies[index][1] == "true") {
                    img = Image.asset('assets/trophies/trophy'+index.toString()+'.png', width: 100);
                    if(index == 0 || index == 3 || index == 6 ||index == 9 ){
                      c = Colors.deepOrangeAccent;

                    }
                    else if(index == 1 || index ==  4|| index == 7 ||index == 10 ){
                      c = Colors.white38;
                    }
                    else {
                      c = Colors.amber;
                    }
                  }

                  return InkWell(
                      onTap: (){_showNotLogDialog(context, index, trophies[index][1], img, c);},
                      child: Container(
                      alignment: Alignment.center,
                      child: Column(
                          children: [
                            const Text(" "),
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: c,
                              child: Padding(
                                padding: const EdgeInsets.all(5), // Border radius
                                child: ClipOval(child: img),
                              ),
                            ),
                            AutoSizeText(trophies[index][0]), //ToDo:nombres y descripciones Peilin
                            const SizedBox(height: 15,)
                          ]
                      )
                  ),
                  );
                }).toList()
            )
        )
    );
  }
}

_showNotLogDialog(BuildContext context, int index, String state, Image img, Color c) {
  AwesomeDialog(
    context: context,
    width: 500,
    animType: AnimType.LEFTSLIDE,
    dialogType: DialogType.NO_HEADER,
    body: _makeTrophyBody(index, state,img, c),
    /*btnOkText:'View in the trophy menu',
      btnOkIcon: Icons.emoji_events,
      btnOkOnPress:(){toRewardsPageDialog(navigatorKey.currentContext!);},
      btnOkColor: Colors.blue,*/
    btnCancelText: 'Ok',
    btnCancelOnPress: () {},
    btnCancelColor: Colors.green,
    headerAnimationLoop: false,
  ).show();
}

_makeTrophyBody(int index, String st, Image img, Color c) {
  late String state;
  if(st == "true"){
    state = "unlocked";
  }
  else {
    state = "locked";
  }
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: c,
          child: Padding(
            padding: const EdgeInsets.all(5), // Border radius
            child: ClipOval(child: img),
          ),
        ),
        const SizedBox(width: 10),
        AutoSizeText(
          "Trophy: " + index.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
        const SizedBox(width: 5),
        AutoSizeText(
          "State: " + state,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          maxLines: 1,
        ),
        const SizedBox(width: 5),
        const AutoSizeText(
          "You can see the trophy in the trophies menu",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
        //todo: AppLocalizations.of(context).alertSureDeleteCarTitle,
        //todo: AppLocalizations.of(context).alertSureDeleteCarContent,

      ],
    ),
  );
}