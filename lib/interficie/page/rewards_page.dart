import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({Key? key}) : super(key: key);
  final trophies = ctrlPresentation.getTrophies();
  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: const NavigationDrawerWidget(), //esto es para que aparezca el botón de menú lateral
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
          return Container(
            alignment: Alignment.center,
            child: Text(trophies[index][1]),
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(15)),
          );
        })
  );
}