import 'package:flutter/material.dart';
import 'package:country_details/core/constants/route_constants.dart';
import 'package:country_details/core/utils/custom_page_transition.dart';
import 'package:country_details/presentation/screens/splash/splash_screen.dart';
import 'package:country_details/presentation/screens/regions/regions_screen.dart';
import 'package:country_details/presentation/screens/countries/countries_screen.dart';
import 'package:country_details/presentation/screens/country_details/country_details_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    
    switch (settings.name) {
      case RouteConstants.splash:
        return CustomPageTransition(page: const SplashScreen());
      
      case RouteConstants.regions:
        return CustomPageTransition(page: const RegionsScreen());
      
      case RouteConstants.countries:
        if (args is String) {
          return CustomPageTransition(
            page: CountriesScreen(regionName: args),
          );
        }
        return _errorRoute();
      
      case RouteConstants.countryDetails:
        if (args is Map<String, dynamic>) {
          return CustomPageTransition(
            page: CountryDetailsScreen(
              countryName: args['name'],
              flagUrl: args['flag'],
              countryData: args['data'],
            ),
          );
        }
        return _errorRoute();
      
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR: Invalid Route'),
        ),
      ),
    );
  }
} 