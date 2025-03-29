import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:country_details/core/constants/app_constants.dart';
import 'package:country_details/core/utils/logger.dart';
import 'package:country_details/data/models/country_model.dart';

class ApiService {
  late final Dio _dio;
  final APICacheManager _cacheManager = APICacheManager();

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );

    // Add interceptors for logging
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          AppLogger.d('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          AppLogger.d('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (error, handler) {
          AppLogger.e('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}', error);
          return handler.next(error);
        },
      ),
    );
  }

  Future<List<Country>> getAllCountries() async {
    try {
      // Check if data exists in cache
      bool isCacheExist = await _cacheManager.isAPICacheKeyExist(AppConstants.allCountriesCacheKey);
      
      if (isCacheExist) {
        // Get data from cache
        var cacheData = await _cacheManager.getCacheData(AppConstants.allCountriesCacheKey);
        final List<dynamic> jsonData = jsonDecode(cacheData.syncData);
        return jsonData.map((country) => Country.fromJson(country)).toList();
      } else {
        // Make API call
        final response = await _dio.get(AppConstants.allCountriesEndpoint);
        
        if (response.statusCode == 200) {
          // Save to cache
          APICacheDBModel cacheModel = APICacheDBModel(
            key: AppConstants.allCountriesCacheKey,
            syncData: jsonEncode(response.data),
          );
          await _cacheManager.addCacheData(cacheModel);
          
          final List<dynamic> jsonData = response.data;
          return jsonData.map((country) => Country.fromJson(country)).toList();
        } else {
          throw Exception('Failed to load countries: ${response.statusCode}');
        }
      }
    } catch (e) {
      AppLogger.e('Error fetching all countries', e);
      throw Exception('Failed to load countries: $e');
    }
  }

  Future<List<Country>> getCountriesByRegion(String region) async {
    try {
      // Cache key for this specific region
      String cacheKey = '${AppConstants.countriesByRegionCacheKey}_$region';
      
      // Check if data exists in cache
      bool isCacheExist = await _cacheManager.isAPICacheKeyExist(cacheKey);
      
      if (isCacheExist) {
        // Get data from cache
        var cacheData = await _cacheManager.getCacheData(cacheKey);
        final List<dynamic> jsonData = jsonDecode(cacheData.syncData);
        return jsonData.map((country) => Country.fromJson(country)).toList();
      } else {
        // Make API call
        final response = await _dio.get('${AppConstants.countriesByRegionEndpoint}/$region');
        
        if (response.statusCode == 200) {
          // Save to cache
          APICacheDBModel cacheModel = APICacheDBModel(
            key: cacheKey,
            syncData: jsonEncode(response.data),
          );
          await _cacheManager.addCacheData(cacheModel);
          
          final List<dynamic> jsonData = response.data;
          return jsonData.map((country) => Country.fromJson(country)).toList();
        } else {
          throw Exception('Failed to load countries by region: ${response.statusCode}');
        }
      }
    } catch (e) {
      AppLogger.e('Error fetching countries by region: $region', e);
      throw Exception('Failed to load countries by region: $e');
    }
  }

  Future<Country> getCountryByName(String name) async {
    try {
      final response = await _dio.get('${AppConstants.countryByNameEndpoint}/$name');
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        return Country.fromJson(jsonData.first);
      } else {
        throw Exception('Failed to load country details: ${response.statusCode}');
      }
    } catch (e) {
      AppLogger.e('Error fetching country by name: $name', e);
      throw Exception('Failed to load country details: $e');
    }
  }

  Future<void> clearCache() async {
    try {
      await _cacheManager.emptyCache();
      AppLogger.i('Cache cleared successfully');
    } catch (e) {
      AppLogger.e('Error clearing cache', e);
      throw Exception('Failed to clear cache: $e');
    }
  }
} 