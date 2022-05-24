import 'package:flutter/material.dart';
import 'package:flutter_project/domini/main_peilin.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  CtrlPresentation ctrlPresentation = CtrlPresentation();

  bool isLastPage = false;

  @override
  void dispose(){
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).navigation.toUpperCase(),
        subtitle: AppLocalizations.of(context).navigationDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/NavigationGIF.gif", width: 250,),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).login.toUpperCase(),
        subtitle: AppLocalizations.of(context).loginDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/login.gif", width: 250,),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).map.toUpperCase(),
        subtitle: "Map page is the main screen of this app.", //todo: cuando tengamos todo lo de rutas solved
        widgetBuilt: Image.asset("assets/brandCars/ds.png"),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).savePointsTitle.toUpperCase(),
        subtitle:AppLocalizations.of(context).savePointsDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/addFavourites.gif", width: 250,),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).getLocationTitle.toUpperCase(),
        subtitle: AppLocalizations.of(context).getLocationDescritpion,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/getYourCurrentLocation.gif", width: 250,),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).filtraTitle.toUpperCase(),
        subtitle: AppLocalizations.of(context).filtraDescription.toUpperCase(),
        widgetBuilt: Image.asset("assets/onboardingScreenshots/filterMarkers.gif", width: 250,),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).garage.toUpperCase(),
        subtitle:
        "Map page is the main screen of this app.", //todo in progress
        widgetBuilt: Image.asset("assets/onboardingScreenshots/addCar.gif"),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).favourites.toUpperCase(),
        subtitle: AppLocalizations.of(context).favDescription,
        widgetBuilt: ctrlPresentation.makeFavouritesLegend(context),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).addNotificationTitle.toUpperCase(),
        subtitle: AppLocalizations.of(context).addNotificationDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/addNotificationDemo.gif", width: 250,),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).achievements.toUpperCase(),
        subtitle:
        "Map page is the main screen of this app.", //todo in progress
        widgetBuilt: Image.asset("assets/brandCars/ds.png"),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).language.toUpperCase(),
        subtitle:
        "Map page is the main screen of this app.", //todo in progress
        widgetBuilt: Image.asset("assets/onboardingScreenshots/languages.gif"),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).appInfo.toUpperCase(),
        subtitle:
        AppLocalizations.of(context).appInfoDescription,
        widgetBuilt: Image.asset("assets/brandCars/ds.png"),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).contactUs.toUpperCase(),
        subtitle:
        "Map page is the main screen of this app.", //todo in progress
        widgetBuilt: Image.asset("assets/brandCars/ds.png"),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).logout.toUpperCase(),
        subtitle:
        "Map page is the main screen of this app.", //todo in progress
        widgetBuilt: Image.asset("assets/brandCars/ds.png"),
      ),
    ];

    return Scaffold(
    body: Container(
      padding: const EdgeInsets.only(bottom: 80),
      child: PageView(
        controller: controller,
        onPageChanged: (index){
          setState(() {
            isLastPage = index == (pages.length-1);
          });
        },
        children: pages,
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
        child: Text(
          AppLocalizations.of(context).start,
          style: const TextStyle(fontSize: 24),
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
              child: Text(AppLocalizations.of(context).skip),
              onPressed: ()=>controller.jumpToPage(pages.length-1)
          ),
          Center(
            child:
            SmoothPageIndicator(
              controller: controller,
              count: pages.length, //num paginas a displayear
              effect: ScrollingDotsEffect(
                activeStrokeWidth: 2.6,
                activeDotScale: 1.3,
                maxVisibleDots: 5,
                radius: 8,
                spacing: 16,
                dotHeight: 12,
                dotWidth: 12,
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
              child: Text(AppLocalizations.of(context).next),
              onPressed: ()=>controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
              ),
          ),
        ],
      ),
  ),
  );
  }

  buildPage({
    required Color color,
    required Widget widgetBuilt,
    required String title,
    required String subtitle
  }) =>
      SingleChildScrollView(
        child: Container(
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 64,),
                Text(
                  title,
                  textAlign: TextAlign.center,
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
                    textAlign: TextAlign.justify,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 40,),
                widgetBuilt,
                const SizedBox(height: 64,),
              ],
            ),
          ),
        ),
      );
}