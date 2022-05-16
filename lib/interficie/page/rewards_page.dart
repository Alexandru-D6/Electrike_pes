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
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: trophies.length,
            itemBuilder: (BuildContext ctx, index) {
              Color col = Colors.amber;
              if(trophies[index][1] == "false") col = Colors.red;
              return Container(
                alignment: Alignment.center,
                child: Text(trophies[index][0]),
                decoration: BoxDecoration(
                    color: col,
                    borderRadius: BorderRadius.circular(15)),

              );
            })
    );
  }
}