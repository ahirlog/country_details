import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:country_details/core/constants/app_constants.dart';
import 'package:country_details/data/providers/providers.dart';

class CustomSearchBar extends ConsumerWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        onChanged: (value) {
          ref.read(searchTermProvider.notifier).state = value;
        },
        decoration: InputDecoration(
          hintText: AppConstants.searchHint,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: Consumer(
            builder: (context, ref, child) {
              final searchTerm = ref.watch(searchTermProvider);
              return searchTerm.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        ref.read(searchTermProvider.notifier).state = '';
                        FocusScope.of(context).unfocus();
                      },
                    )
                  : const SizedBox.shrink();
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
} 