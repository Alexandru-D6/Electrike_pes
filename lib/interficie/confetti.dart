import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class Confetti extends StatefulWidget {
  @override
  ConfettiState createState() => ConfettiState();
}

class ConfettiState extends State<Confetti> {
  static late ConfettiController controllerCenterRight;
  static late ConfettiController controllerCenterLeft;

  @override
  void initState() {
    super.initState();
    controllerCenterRight = ConfettiController(duration: const Duration(milliseconds: 500));
    controllerCenterLeft = ConfettiController(duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    controllerCenterRight.dispose();
    controllerCenterLeft.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[

          //CENTER RIGHT -- Emit left
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: controllerCenterRight,
              blastDirection: pi, // radial value - RIGHT
              emissionFrequency: 0.6,
              minimumSize: const Size(5,
                  5), // set the minimum potential size for the confetti (width, height)
              maximumSize: const Size(15,
                  15), // set the maximum potential size for the confetti (width, height)
              numberOfParticles: 1,
              gravity: 0.1,
            ),
          ),

          //CENTER LEFT - Emit right
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: controllerCenterLeft,
              blastDirection: 0, // radial value - RIGHT
              emissionFrequency: 0.6,
              minimumSize: const Size(5,
                  5), // set the minimum potential size for the confetti (width, height)
              maximumSize: const Size(15,
                  25), // set the maximum potential size for the confetti (width, height)
              numberOfParticles: 1,
              gravity: 0.1,
            ),
          ),
        ],
      ),
    );
  }

}