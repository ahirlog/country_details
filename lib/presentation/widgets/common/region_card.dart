import 'package:flutter/material.dart';
import 'package:country_details/core/constants/app_constants.dart';
import 'package:country_details/core/constants/route_constants.dart';
import 'package:country_details/core/utils/navigation_service.dart';

class RegionCard extends StatelessWidget {
  final int index;

  const RegionCard({
    super.key, 
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          NavigationService().navigateTo(
            RouteConstants.countries,
            arguments: AppConstants.regionNames[index],
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                AppConstants.regionImages[index],
                height: 120,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                AppConstants.regionNames[index],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
} 