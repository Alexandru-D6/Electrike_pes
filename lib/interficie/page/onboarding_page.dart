import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
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
            isLastPage = index == 2;
          });
        },
        children: [
          Container(
            color: Colors.red,
            child: const Center(child: Text('Text 1'),),
          ),
          Container(
            color: Colors.green,
            child: const Center(child: Text('Text 2'),),
          ),
          Container(
            color: Colors.blue,
            child: const Center(child: Text('Text 3'),),
          ),
        ],
      ),
    ),
    bottomSheet: isLastPage
      ? TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
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
          ctrlPresentation.toMainPage(context);
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
              onPressed: ()=>controller.jumpToPage(2)
          ),
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: 3, //num paginas a displayear
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
}