import 'dart:async';

import 'package:country_details/core/constants/app_constants.dart';
import 'package:country_details/core/constants/route_constants.dart';
import 'package:country_details/core/theme/app_theme.dart';
import 'package:country_details/core/utils/navigation_service.dart';
import 'package:country_details/presentation/widgets/common/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    
    _animationController.forward();
    
    Timer(
      AppConstants.splashDuration,
      () => NavigationService().navigateToWithClearStack(RouteConstants.regions),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                AppTheme.primaryColorDark.withOpacity(0.7),
                AppTheme.primaryColor.withOpacity(0.9),
              ],
              stops: const [0.1, 1.0],
            ),
          ),
          child: FadeTransition(
            opacity: _fadeInAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appNameText(),
                loadingAnimation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded appNameText() {
    return Expanded(
      flex: 3,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'COUNTRY',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                shadows: [
                  const Shadow(
                    blurRadius: 10.0,
                    color: Colors.black38,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            Text(
              'DETAILS',
              style: GoogleFonts.poppins(
                color: AppTheme.accentColor,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                letterSpacing: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded loadingAnimation() {
    return const Expanded(
      flex: 1,
      child: CustomLoading(
        size: 50,
        color: Colors.white,
      ),
    );
  }
} 