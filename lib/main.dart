// ignore_for_file: deprecated_member_use

import 'package:country_details/core/constants/route_constants.dart';
import 'package:country_details/core/theme/app_theme.dart';
import 'package:country_details/core/utils/logger.dart';
import 'package:country_details/core/utils/navigation_service.dart';
import 'package:country_details/core/utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Set preferred orientations
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    // Set system UI overlay styles
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppTheme.primaryColorDark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  } catch (e) {
    AppLogger.e('Error during app initialization', e);
  }
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Details',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      navigatorKey: NavigationService().navigatorKey,
      initialRoute: RouteConstants.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
