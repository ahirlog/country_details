class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // API Constants
  static const String baseUrl = 'https://restcountries.com/v3.1';
  static const String allCountriesEndpoint = '/all';
  static const String countryByNameEndpoint = '/name';
  static const String countryByCodeEndpoint = '/alpha';
  static const String countriesByRegionEndpoint = '/region';
  
  // Cache Keys
  static const String allCountriesCacheKey = 'ALL_COUNTRIES_CACHE';
  static const String countriesByRegionCacheKey = 'COUNTRIES_BY_REGION_CACHE';
  
  // Animation Duration
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration pageTransitionDuration = Duration(milliseconds: 400);
  
  // Region Names
  static const List<String> regionNames = [
    "Africa",
    "Antarctica",
    "Asia",
    "Europe",
    "North America",
    "Oceania",
    "South America",
  ];
  
  // Region Images
  static const List<String> regionImages = [
    "assets/africa.jpeg",
    "assets/antarctica.jpeg",
    "assets/asia.jpeg",
    "assets/europe.jpeg",
    "assets/north_america.jpeg",
    "assets/oceania.jpeg",
    "assets/south_america.jpeg",
  ];
  
  // App Strings
  static const String appName = 'Country Details';
  static const String regionsTitle = 'REGIONS';
  static const String countriesTitle = 'COUNTRIES';
  static const String detailsTitle = 'DETAILS';
  static const String errorTitle = 'Error';
  static const String errorMessage = 'Something went wrong. Please try again.';
  static const String noInternetMessage = 'No internet connection';
  static const String retry = 'Retry';
  static const String noDataMessage = 'No data available';
  static const String searchHint = 'Search countries...';
  
  // Country Detail Keys
  static const String topLevelDomain = 'Top Level Domain';
  static const String countryCode = 'Country Code';
  static const String capital = 'Capital';
  static const String currency = 'Currency';
  static const String dialingCode = 'Dialing Code';
  static const String population = 'Population';
  static const String demonym = 'Demonym';
  static const String region = 'Region';
  static const String subregion = 'Subregion';
  static const String language = 'Language';
  static const String latitudeLongitude = 'Latitude & Longitude';
  static const String area = 'Area';
  
  // Sharing
  static const String shareTitle = 'Check out this country:';
  static const String openInMaps = 'Open in Maps';
  static const String share = 'Share';
} 