import 'package:flutter/material.dart';
import 'package:flutter_project/domini/main_peilin.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();

  bool isLastPage = false;

  @override
  void dispose(){
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      padding: const EdgeInsets.only(bottom: 80),
      child: PageView(
        controller: controller,
        onPageChanged: (index){
          setState(() {
            isLastPage = index == 10;
          });
        },
        children: [
          buildPage(
            color: Colors.green.shade100,
            title: "NAVIGATION",
            subtitle:
            "Map page is the main screen of this app.",
            widgetBuilt: Image.asset("assets/brandCars/ds.png"),
          ),
          buildPage(
            color: Colors.green.shade100,
            title: "LOG-IN",
            subtitle:
            "Map page is the main screen of this app.",
            widgetBuilt: Image.asset("assets/brandCars/ds.png"),
          ),
          buildPage(
            color: Colors.green.shade100,
            title: "MAP",
            subtitle:
            "Map page is the main screen of this app.",
            widgetBuilt: Image.asset("assets/brandCars/ds.png"),
          ),
          buildPage(
            color: Colors.green.shade100,
            title: "FILTRA LOS PUNTOS QUE QUIERES VER",
            subtitle:
            "Map page is the main screen of this app.",
            widgetBuilt: Image.asset("assets/brandCars/ds.png"),
          ),
          buildPage(
            color: Colors.green.shade100,
            title: "GARAGE",
            subtitle:
            "Map page is the main screen of this app.",
            widgetBuilt: Image.asset("assets/brandCars/ds.png"),
          ),
          buildPage(
            color: Colors.green.shade100,
            title: "FAVOURITES",
            subtitle:
            "Map page is the main screen of this app.",
            widgetBuilt: Image.asset("assets/brandCars/ds.png"),
          ),
          buildPage(
            color: Colors.green.shade100,
            title: "ACHIEVEMENTS",
            subtitle:
            "Map page is the main screen of this app.",
            widgetBuilt: Image.asset("assets/brandCars/ds.png"),
          ),
          buildPage(
            color: Colors.green.shade100,
            title: "LANGUAGE",
            subtitle:
            "Map page is the main screen of this app.",
            widgetBuilt: Image.asset("assets/brandCars/ds.png"),
          ),
          buildPage(
            color: Colors.green.shade100,
            title: "INFO APP",
            subtitle:
            "Map page is the main screen of this app.",
            widgetBuilt: Image.asset("assets/brandCars/ds.png"),
          ),
          buildPage(
            color: Colors.green.shade100,
            title: "CONTACT US",
            subtitle:
            "Map page is the main screen of this app.",
            widgetBuilt: Image.asset("assets/brandCars/ds.png"),
          ),
          buildPage(
            color: Colors.green.shade100,
            title: "LOG-OUT",
            subtitle:
            "Map page is the main screen of this app.",
            widgetBuilt: Image.asset("assets/brandCars/ds.png"),
          ),
        ],
      ),
    ),
    bottomSheet: isLastPage
      ? TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          primary: Colors.white,
          backgroundColor: Colors.teal.shade700,
          minimumSize: const Size.fromHeight(80),
        ),
        child: const Text(
          'Get Started', //todo:translate
          style: TextStyle(fontSize: 24),
        ),
        onPressed: () async{
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyApp()),
          );
        }
    )
          : Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              child: const Text('SKIP'), //todo: translate
              onPressed: ()=>controller.jumpToPage(10)
          ),
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: 11, //num paginas a displayear
              effect: WormEffect(
                spacing: 16,
                dotColor: Colors.black26,
                activeDotColor: Colors.teal.shade700,
              ),
              onDotClicked: (index) => controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
              ),
            ),
          ),
          TextButton(
              child: const Text('NEXT'), //todo: translate
              onPressed: ()=>controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
              ),
          ),
        ],
      ),
  ),
  );

  buildPage({
    required Color color,
    required Widget widgetBuilt,
    required String title,
    required String subtitle
  }) =>
      SingleChildScrollView(
        child: Container(
          color: color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 64,),
              Text(
                title,
                style: TextStyle(
                  color: Colors.teal.shade700,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
              const SizedBox(height: 64,),
              widgetBuilt
            ],
          ),
        ),
      );
}