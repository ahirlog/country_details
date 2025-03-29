import 'package:country_details/core/utils/logger.dart';
import 'package:country_details/data/models/country_model.dart';
import 'package:country_details/data/repositories/country_repository.dart';
import 'package:country_details/data/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Service providers
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// Repository providers
final countryRepositoryProvider = Provider<CountryRepository>((ref) {
  return CountryRepository(apiService: ref.watch(apiServiceProvider));
});

// Notifier providers
final allCountriesProvider = FutureProvider<List<Country>>((ref) async {
  try {
    return await ref.watch(countryRepositoryProvider).getAllCountries();
  } catch (e) {
    AppLogger.e('Error in allCountriesProvider', e);
    rethrow;
  }
});

final countriesByRegionProvider = FutureProvider.family<List<Country>, String>((ref, region) async {
  try {
    return await ref.watch(countryRepositoryProvider).getCountriesByRegion(region);
  } catch (e) {
    AppLogger.e('Error in countriesByRegionProvider', e);
    rethrow;
  }
});

final countriesByContinentProvider = FutureProvider.family<List<Country>, String>((ref, continent) async {
  try {
    return await ref.watch(countryRepositoryProvider).getCountriesByContinent(continent);
  } catch (e) {
    AppLogger.e('Error in countriesByContinentProvider', e);
    rethrow;
  }
});

final selectedCountryProvider = StateProvider<Country?>((ref) => null);

final searchTermProvider = StateProvider<String>((ref) => '');

final filteredCountriesProvider = Provider.family<List<Country>, List<Country>>((ref, countries) {
  final searchTerm = ref.watch(searchTermProvider).toLowerCase();
  
  if (searchTerm.isEmpty) {
    return countries;
  }
  
  return countries.where((country) {
    return country.name.toLowerCase().contains(searchTerm) ||
        country.region.toLowerCase().contains(searchTerm) ||
        country.subregion.toLowerCase().contains(searchTerm) ||
        country.capital.any((capital) => capital.toLowerCase().contains(searchTerm));
  }).toList();
}); 