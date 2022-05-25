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

    return Scaffold(
        drawer: const NavigationDrawerWidget(),
        //esto es para que aparezca el botón de menú lateral
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).achievements), //todo: translate
          centerTitle: false,
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
                      c = const Color(0xC2C94B11);

                    }
                    else if(index == 1 || index ==  4|| index == 7 ||index == 10 ){
                      c = Colors.grey;
                    }
                    else {
                      c = const Color(0xFFFFD700);
                    }
                  }
                  String trophyname = "error";
                  String trophydesc = "error";
                  switch (trophies[index][0]){
                    case "0":
                      trophyname=AppLocalizations.of(context).trophy0;
                      trophydesc=AppLocalizations.of(context).trophy0desc;
                      break;
                    case "1":
                      trophyname=AppLocalizations.of(context).trophy1;
                      trophydesc=AppLocalizations.of(context).trophy1desc;
                      break;
                    case "2":
                      trophyname=AppLocalizations.of(context).trophy2;
                      trophydesc=AppLocalizations.of(context).trophy2desc;
                      break;
                    case "3":
                      trophyname=AppLocalizations.of(context).trophy3;
                      trophydesc=AppLocalizations.of(context).trophy3desc;
                      break;
                    case "4":
                      trophyname=AppLocalizations.of(context).trophy4;
                      trophydesc=AppLocalizations.of(context).trophy4desc;
                      break;
                    case "5":
                      trophyname=AppLocalizations.of(context).trophy5;
                      trophydesc=AppLocalizations.of(context).trophy5desc;
                      break;
                    case "6":
                      trophyname=AppLocalizations.of(context).trophy6;
                      trophydesc=AppLocalizations.of(context).trophy6desc;
                      break;
                    case "7":
                      trophyname=AppLocalizations.of(context).trophy7;
                      trophydesc=AppLocalizations.of(context).trophy7desc;
                      break;
                    case "8":
                      trophyname=AppLocalizations.of(context).trophy8;
                      trophydesc=AppLocalizations.of(context).trophy8desc;
                      break;
                    case "9":
                      trophyname=AppLocalizations.of(context).trophy9;
                      trophydesc=AppLocalizations.of(context).trophy9desc;
                      break;
                    case "10":
                      trophyname=AppLocalizations.of(context).trophy10;
                      trophydesc=AppLocalizations.of(context).trophy10desc;
                      break;
                    case "11":
                      trophyname=AppLocalizations.of(context).trophy11;
                      trophydesc=AppLocalizations.of(context).trophy11desc;
                      break;
                  }

                  return InkWell(
                      onTap: (){_showNotLogDialog(context, trophyname,trophydesc, trophies[index][1], img, c);},
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
                            const SizedBox(height: 15,),
                            AutoSizeText(
                              trophyname,
                              textAlign: TextAlign.center,
                            ), //ToDo:nombres y descripciones Peilin
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

_showNotLogDialog(BuildContext context, String name, String desc, String state, Image img, Color c) {
  AwesomeDialog(
    context: context,
    width: 500,
    animType: AnimType.LEFTSLIDE,
    dialogType: DialogType.NO_HEADER,
    body: _makeTrophyBody(context, name, desc, state,img, c),
    btnCancelText: 'Ok',
    btnCancelOnPress: () {},
    btnCancelColor: Colors.green,
    headerAnimationLoop: false,
  ).show();
}

_makeTrophyBody(BuildContext context,String name, String desc, String st, Image img, Color c) {
  late String state;
  if(st == "true"){
    state = AppLocalizations.of(context).unlocked;
  }
  else {
    state = AppLocalizations.of(context).locked;
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
          AppLocalizations.of(context).nametrophy + name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
        const SizedBox(width: 5),
        AutoSizeText(
          AppLocalizations.of(context).state + state,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          maxLines: 1,
        ),
        const SizedBox(width: 5),
        AutoSizeText(
          desc,
          style: const TextStyle(
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