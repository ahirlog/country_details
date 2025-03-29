import 'package:country_details/core/utils/logger.dart';
import 'package:country_details/data/models/country_model.dart';
import 'package:country_details/data/services/api_service.dart';

class CountryRepository {
  final ApiService _apiService;

  CountryRepository({required ApiService apiService}) : _apiService = apiService;

  Future<List<Country>> getAllCountries() async {
    try {
      final countries = await _apiService.getAllCountries();
      return countries;
    } catch (e) {
      AppLogger.e('Error in repository - getAllCountries()', e);
      rethrow;
    }
  }

  Future<List<Country>> getCountriesByRegion(String region) async {
    try {
      final countries = await _apiService.getCountriesByRegion(region);
      return countries;
    } catch (e) {
      AppLogger.e('Error in repository - getCountriesByRegion($region)', e);
      rethrow;
    }
  }

  Future<Country> getCountryByName(String name) async {
    try {
      final country = await _apiService.getCountryByName(name);
      return country;
    } catch (e) {
      AppLogger.e('Error in repository - getCountryByName($name)', e);
      rethrow;
    }
  }

  Future<List<Country>> getCountriesByContinent(String continent) async {
    try {
      // First get all countries
      final allCountries = await _apiService.getAllCountries();
      
      // Filter by continent
      final filteredCountries = allCountries
          .where((country) => 
              country.continents.isNotEmpty && 
              country.continents.contains(continent))
          .toList();
      
      return filteredCountries;
    } catch (e) {
      AppLogger.e('Error in repository - getCountriesByContinent($continent)', e);
      rethrow;
    }
  }

  Future<void> clearCache() async {
    try {
      await _apiService.clearCache();
    } catch (e) {
      AppLogger.e('Error in repository - clearCache()', e);
      rethrow;
    }
  }
} 