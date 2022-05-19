import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';

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
          title: const Text('Rewards'),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30),
            itemCount: trophies.length,
            itemBuilder: (BuildContext ctx, index) {
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
              else {img = Image.asset('assets/trophies/lockedtrophy'+index.toString()+'.png', width: 100);}

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
                    Text(trophies[index][0]),
                      Text(trophies[index][0])//ToDo:nombres y descripciones Peilin
                    ]
                )
              );
            })
    );
  }
}