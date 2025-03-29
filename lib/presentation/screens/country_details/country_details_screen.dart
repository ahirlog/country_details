import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_details/core/constants/app_constants.dart';
import 'package:country_details/data/models/country_model.dart';
import 'package:country_details/presentation/widgets/common/custom_loading.dart';
import 'package:country_details/presentation/widgets/common/detail_item.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CountryDetailsScreen extends StatelessWidget {
  final String countryName;
  final String flagUrl;
  final Country countryData;
  
  const CountryDetailsScreen({
    super.key,
    required this.countryName,
    required this.flagUrl,
    required this.countryData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.detailsTitle),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFlagSection(),
            _buildActionsRow(context),
            Expanded(
              child: _buildDetailsSection(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlagSection() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Hero(
        tag: 'flag-$countryName',
        child: CachedNetworkImage(
          imageUrl: flagUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[200],
            child: const Center(child: CustomLoading()),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: const Icon(Icons.error, size: 50),
          ),
        ),
      ),
    );
  }

  Widget _buildActionsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            context: context,
            icon: Icons.share,
            label: AppConstants.share,
            onPressed: _shareCountryDetails,
          ),
          if (countryData.getMapUrl().isNotEmpty)
            _buildActionButton(
              context: context,
              icon: Icons.public,
              label: 'View on Web',
              onPressed: () => _launchUrl(countryData.getMapUrl()),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 18),
          label: Text(
            label,
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                countryData.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            if (countryData.officialName != countryData.name)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    '(${countryData.officialName})',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            const Divider(height: 32),
            DetailItem(
              icon: Icons.location_city,
              title: AppConstants.capital,
              value: countryData.capital.isNotEmpty ? countryData.capital.join(', ') : 'N/A',
            ),
            DetailItem(
              icon: Icons.public,
              title: AppConstants.region,
              value: countryData.region,
            ),
            DetailItem(
              icon: Icons.map,
              title: AppConstants.subregion,
              value: countryData.subregion.isNotEmpty ? countryData.subregion : 'N/A',
            ),
            DetailItem(
              icon: Icons.people,
              title: AppConstants.population,
              value: countryData.population.toString(),
            ),
            DetailItem(
              icon: Icons.language,
              title: AppConstants.language,
              value: countryData.getAllLanguages().join(', '),
            ),
            DetailItem(
              icon: Icons.attach_money,
              title: AppConstants.currency,
              value: countryData.getCurrencyInfo(),
            ),
            DetailItem(
              icon: Icons.phone,
              title: AppConstants.dialingCode,
              value: countryData.getDialingCode(),
            ),
            DetailItem(
              icon: Icons.person,
              title: AppConstants.demonym,
              value: (countryData.demonyms.isNotEmpty && countryData.demonyms.containsKey('eng') && countryData.demonyms['eng']?['m'] != null) 
                  ? countryData.demonyms['eng']!['m']! 
                  : 'N/A',
            ),
            DetailItem(
              icon: Icons.aspect_ratio,
              title: AppConstants.area,
              value: '${countryData.area.toStringAsFixed(2)} km²',
            ),
            DetailItem(
              icon: Icons.web,
              title: AppConstants.topLevelDomain,
              value: countryData.tld.isNotEmpty ? countryData.tld.join(', ') : 'N/A',
            ),
            DetailItem(
              icon: Icons.code,
              title: AppConstants.countryCode,
              value: countryData.cca2,
            ),
            DetailItem(
              icon: Icons.my_location,
              title: AppConstants.latitudeLongitude,
              value: countryData.latlng.isNotEmpty 
                  ? '${countryData.latlng[0]}, ${countryData.latlng[1]}'
                  : 'N/A',
            ),
          ],
        ),
      ),
    );
  }

  void _shareCountryDetails() {
    final text = '''
${AppConstants.shareTitle}

Country: ${countryData.name}
Official Name: ${countryData.officialName}
Capital: ${countryData.capital.isNotEmpty ? countryData.capital.join(', ') : 'N/A'}
Region: ${countryData.region}
Population: ${countryData.population}
Languages: ${countryData.getAllLanguages().join(', ')}

${countryData.getMapUrl()}
''';

    Share.share(text);
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
} 