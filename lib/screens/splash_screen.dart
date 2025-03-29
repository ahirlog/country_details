// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:country_details/screens/region_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const RegionScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: backgroundImage(),
        child: Container(
          decoration: backgroundGrdient(context),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            appNameText(),
            loadingAnimation(context),
          ]),
        ),
      ),
    );
  }

  BoxDecoration backgroundGrdient(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            Theme.of(context).primaryColorLight.withOpacity(0.2),
            Colors.black,
          ],
          stops: const [
            0.1,
            1.0
          ]),
    );
  }

  BoxDecoration backgroundImage() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/background.png"),
        fit: BoxFit.cover,
      ),
    );
  }

  Expanded appNameText() {
    return Expanded(
      flex: 3,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'COUNTRY',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.w900,
                decoration: TextDecoration.underline,
              ),
            ),
            Text(
              'DETAILS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded loadingAnimation(BuildContext context) {
    return Expanded(
      flex: 1,
      child: LoadingAnimationWidget.halfTriangleDot(
        color: Theme.of(context).colorScheme.secondary,
        size: 30,
      ),
    );
  }
}
