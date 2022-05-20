import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:responsive_grid/responsive_grid.dart';

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
              minSpacing: 10,
              children: [for(var i=0; i<trophies.length; i+=1) i].map((index) {
                Image img = Image.asset('assets/trophies/trophy.png', width: 100);
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
                else {img = Image.asset('assets/trophies/trophy.png', width: 100);}

                return Container(
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
                );
              }).toList()
          )
        )
    );
  }
}