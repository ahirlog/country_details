import 'package:country_details/core/constants/app_constants.dart';
import 'package:country_details/data/models/country_model.dart';
import 'package:country_details/data/providers/providers.dart';
import 'package:country_details/presentation/widgets/common/country_card.dart';
import 'package:country_details/presentation/widgets/common/custom_loading.dart';
import 'package:country_details/presentation/widgets/common/error_display.dart';
import 'package:country_details/presentation/widgets/common/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountriesScreen extends ConsumerWidget {
  final String regionName;

  const CountriesScreen({
    super.key,
    required this.regionName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesAsync = ref.watch(countriesByContinentProvider(regionName));
    
    return Scaffold(
      appBar: AppBar(
        title: Text('${regionName.toUpperCase()} ${AppConstants.countriesTitle}'),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
            opacity: 0.15,
          ),
        ),
        child: Column(
          children: [
            const CustomSearchBar(),
            Expanded(
              child: countriesAsync.when(
                data: (countries) => _buildCountriesList(countries, ref),
                loading: () => const CustomLoading(),
                error: (error, stackTrace) => ErrorDisplay(
                  onRetry: () => ref.refresh(countriesByContinentProvider(regionName)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountriesList(List<Country> countries, WidgetRef ref) {
    final filteredCountries = ref.watch(filteredCountriesProvider(countries));
    
    if (filteredCountries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 48,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No countries found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: filteredCountries.length,
      itemBuilder: (context, index) => CountryCard(
        country: filteredCountries[index],
      ),
    );
  }
} 