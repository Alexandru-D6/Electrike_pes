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
    double widthGif = 220;
    List<Widget> pages = [
      buildPage(//DONE
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).navigation.toUpperCase(),
        subtitle: AppLocalizations.of(context).navigationDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/NavigationGIF.gif", width: widthGif,),
      ),
      buildPage(//DONE
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).login.toUpperCase(),
        subtitle: AppLocalizations.of(context).loginDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/login.gif", width: widthGif,),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).profile.toUpperCase(),
        subtitle: AppLocalizations.of(context).profileDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/profile.gif", width: widthGif,),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).deleteAccountTitle.toUpperCase(),
        subtitle: AppLocalizations.of(context).deleteAccountDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/deleteAccount.gif", width: widthGif,),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).map.toUpperCase(),
        subtitle: AppLocalizations.of(context).mapDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/map.gif", width: widthGif,),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).stRouteTitle.toUpperCase(),
        subtitle: AppLocalizations.of(context).stRouteDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/st.gif", width: widthGif,),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).chRouteTitle.toUpperCase(),
        subtitle: AppLocalizations.of(context).chRouteDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/ch.gif", width: widthGif,),
      ),
      buildPage(
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).ecoRouteTitle.toUpperCase(),
        subtitle: AppLocalizations.of(context).ecoRouteDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/eco.gif", width: widthGif,),
      ),
      buildPage(//DONE
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).savePointsTitle.toUpperCase(),
        subtitle:AppLocalizations.of(context).savePointsDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/addFavourites.gif", width: widthGif,),
      ),
      buildPage(//DONE
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).getLocationTitle.toUpperCase(),
        subtitle: AppLocalizations.of(context).getLocationDescritpion,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/getYourCurrentLocation.gif", width: widthGif,),
      ),
      buildPage(//DONE
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).filtraTitle.toUpperCase(),
        subtitle: AppLocalizations.of(context).filtraDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/filterMarkers.gif", width: widthGif,),
      ),
      buildPage(//DONE
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).garage.toUpperCase(),
        subtitle: AppLocalizations.of(context).addCarDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/addCar.gif", width: widthGif,),
      ),
      buildPage(//DONE
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).favourites.toUpperCase(),
        subtitle: AppLocalizations.of(context).favDescription,
        widgetBuilt: ctrlPresentation.makeFavouritesLegend(context),
      ),
      buildPage(//DONE
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).addNotificationTitle.toUpperCase(),
        subtitle: AppLocalizations.of(context).addNotificationDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/addNotificationDemo.gif", width: widthGif,),
      ),
      buildPage(//DONE
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).achievements.toUpperCase(),
        subtitle: AppLocalizations.of(context).achievementsDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/rewards.gif", width: widthGif,),
      ),
      buildPage(//DONE
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).language.toUpperCase(),
        subtitle: AppLocalizations.of(context).languageDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/languages.gif", width: widthGif,),
      ),
      buildPage(//DONE
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).appInfo.toUpperCase(),
        subtitle: AppLocalizations.of(context).appInfoDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/tutorial.gif", width: widthGif,),
      ),
      buildPage(//DONE
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).contactUs.toUpperCase(),
        subtitle: AppLocalizations.of(context).contactUsDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/contactUs.gif", width: widthGif,),
      ),
      buildPage(//DONE
        color: Colors.green.shade100,
        title: AppLocalizations.of(context).logout.toUpperCase(),
        subtitle: AppLocalizations.of(context).logoutDescription,
        widgetBuilt: Image.asset("assets/onboardingScreenshots/logout.gif", width: widthGif,),
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