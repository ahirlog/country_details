class Country {
  final String name;
  final String commonName;
  final String officialName;
  final String flagUrl;
  final String? flagAlt;
  final String? coatOfArmsUrl;
  final List<String> tld;
  final String cca2;
  final String ccn3;
  final String cca3;
  final String cioc;
  final bool independent;
  final String status;
  final bool unMember;
  final Map<String, Currency> currencies;
  final Map<String, String> idd;
  final List<String> capital;
  final List<String> altSpellings;
  final String region;
  final String subregion;
  final Map<String, String> languages;
  final Map<String, Map<String, String>> translations;
  final List<double> latlng;
  final bool landlocked;
  final List<String> borders;
  final double area;
  final Map<String, Map<String, String>> demonyms;
  final String flag;
  final Map<String, String> maps;
  final int population;
  final String fifa;
  final Map<String, String> car;
  final List<String> timezones;
  final List<String> continents;
  final String? flagPng;
  final String? flagSvg;
  final String? coatOfArmsPng;
  final String? coatOfArmsSvg;
  final String? startOfWeek;
  final Map<String, List<String>>? capitalInfo;
  final Map<String, String>? postalCode;

  Country({
    required this.name,
    required this.commonName,
    required this.officialName,
    required this.flagUrl,
    this.flagAlt,
    this.coatOfArmsUrl,
    required this.tld,
    required this.cca2,
    required this.ccn3,
    required this.cca3,
    required this.cioc,
    required this.independent,
    required this.status,
    required this.unMember,
    required this.currencies,
    required this.idd,
    required this.capital,
    required this.altSpellings,
    required this.region,
    required this.subregion,
    required this.languages,
    required this.translations,
    required this.latlng,
    required this.landlocked,
    required this.borders,
    required this.area,
    required this.demonyms,
    required this.flag,
    required this.maps,
    required this.population,
    required this.fifa,
    required this.car,
    required this.timezones,
    required this.continents,
    this.flagPng,
    this.flagSvg,
    this.coatOfArmsPng,
    this.coatOfArmsSvg,
    this.startOfWeek,
    this.capitalInfo,
    this.postalCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    Map<String, Currency> currenciesMap = {};
    if (json['currencies'] != null) {
      json['currencies'].forEach((key, value) {
        currenciesMap[key] = Currency.fromJson(value);
      });
    }

    Map<String, String> languagesMap = {};
    if (json['languages'] != null) {
      json['languages'].forEach((key, value) {
        languagesMap[key] = value.toString();
      });
    }

    Map<String, Map<String, String>> translationsMap = {};
    if (json['translations'] != null) {
      json['translations'].forEach((key, value) {
        translationsMap[key] = {
          'official': value['official'],
          'common': value['common']
        };
      });
    }

    Map<String, Map<String, String>> demonymsMap = {};
    if (json['demonyms'] != null) {
      json['demonyms'].forEach((key, value) {
        demonymsMap[key] = {
          'f': value['f'],
          'm': value['m']
        };
      });
    }

    Map<String, String> mapsMap = {};
    if (json['maps'] != null) {
      json['maps'].forEach((key, value) {
        mapsMap[key] = value.toString();
      });
    }

    Map<String, String> carMap = {};
    if (json['car'] != null) {
      json['car'].forEach((key, value) {
        if (value is String) {
          carMap[key] = value;
        } else if (value is List) {
          carMap[key] = value.join(', ');
        }
      });
    }

    Map<String, String> iddMap = {};
    if (json['idd'] != null && json['idd'] is Map) {
      json['idd'].forEach((key, value) {
        if (value is String) {
          iddMap[key] = value;
        } else if (value is List) {
          iddMap[key] = value.join(', ');
        }
      });
    }

    return Country(
      name: json['name']['common'] ?? '',
      commonName: json['name']['common'] ?? '',
      officialName: json['name']['official'] ?? '',
      flagUrl: json['flags']?['png'] ?? '',
      flagAlt: json['flags']?['alt'],
      coatOfArmsUrl: json['coatOfArms']?['png'],
      tld: json['tld'] != null ? List<String>.from(json['tld'].map((x) => x.toString())) : [],
      cca2: json['cca2'] ?? '',
      ccn3: json['ccn3'] ?? '',
      cca3: json['cca3'] ?? '',
      cioc: json['cioc'] ?? '',
      independent: json['independent'] ?? false,
      status: json['status'] ?? '',
      unMember: json['unMember'] ?? false,
      currencies: currenciesMap,
      idd: iddMap,
      capital: json['capital'] != null ? List<String>.from(json['capital'].map((x) => x.toString())) : [],
      altSpellings: json['altSpellings'] != null ? List<String>.from(json['altSpellings'].map((x) => x.toString())) : [],
      region: json['region'] ?? '',
      subregion: json['subregion'] ?? '',
      languages: languagesMap,
      translations: translationsMap,
      latlng: json['latlng'] != null ? List<double>.from(json['latlng'].map((x) => x.toDouble())) : [0.0, 0.0],
      landlocked: json['landlocked'] ?? false,
      borders: json['borders'] != null ? List<String>.from(json['borders'].map((x) => x.toString())) : [],
      area: (json['area'] ?? 0.0).toDouble(),
      demonyms: demonymsMap,
      flag: json['flag'] ?? '',
      maps: mapsMap,
      population: json['population'] ?? 0,
      fifa: json['fifa'] ?? '',
      car: carMap,
      timezones: json['timezones'] != null ? List<String>.from(json['timezones'].map((x) => x.toString())) : [],
      continents: json['continents'] != null ? List<String>.from(json['continents'].map((x) => x.toString())) : [],
      flagPng: json['flags']?['png'],
      flagSvg: json['flags']?['svg'],
      coatOfArmsPng: json['coatOfArms']?['png'],
      coatOfArmsSvg: json['coatOfArms']?['svg'],
      startOfWeek: json['startOfWeek'],
      capitalInfo: json['capitalInfo'] != null 
          ? _mapCapitalInfo(json['capitalInfo'])
          : null,
      postalCode: json['postalCode'] != null 
          ? Map<String, String>.from(json['postalCode'].map((key, value) => MapEntry(key, value.toString())))
          : null,
    );
  }

  // Helper method to safely convert capitalInfo
  static Map<String, List<String>>? _mapCapitalInfo(Map<String, dynamic> capitalInfo) {
    final result = <String, List<String>>{};
    capitalInfo.forEach((key, value) {
      if (value is List) {
        result[key] = List<String>.from(value.map((x) => x.toString()));
      }
    });
    return result;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': {
        'common': commonName,
        'official': officialName
      },
      'flags': {
        'png': flagPng,
        'svg': flagSvg,
        'alt': flagAlt
      },
      'coatOfArms': {
        'png': coatOfArmsPng,
        'svg': coatOfArmsSvg
      },
      'tld': tld,
      'cca2': cca2,
      'ccn3': ccn3,
      'cca3': cca3,
      'cioc': cioc,
      'independent': independent,
      'status': status,
      'unMember': unMember,
      'currencies': currencies,
      'idd': idd,
      'capital': capital,
      'altSpellings': altSpellings,
      'region': region,
      'subregion': subregion,
      'languages': languages,
      'translations': translations,
      'latlng': latlng,
      'landlocked': landlocked,
      'borders': borders,
      'area': area,
      'demonyms': demonyms,
      'flag': flag,
      'maps': maps,
      'population': population,
      'fifa': fifa,
      'car': car,
      'timezones': timezones,
      'continents': continents,
      'startOfWeek': startOfWeek,
      'capitalInfo': capitalInfo,
      'postalCode': postalCode,
    };
  }

  String get formattedPopulation {
    if (population >= 1000000000) {
      return '${(population / 1000000000).toStringAsFixed(1)}B';
    } else if (population >= 1000000) {
      return '${(population / 1000000).toStringAsFixed(1)}M';
    } else if (population >= 1000) {
      return '${(population / 1000).toStringAsFixed(1)}K';
    }
    return population.toString();
  }

  String getDialingCode() {
    if (idd.isNotEmpty && idd.containsKey('root') && idd.containsKey('suffixes')) {
      return '${idd['root'] ?? ''}${idd['suffixes'] ?? ''}';
    }
    return 'N/A';
  }

  String getMainLanguage() {
    if (languages.isNotEmpty) {
      return languages.values.first;
    }
    return 'N/A';
  }

  List<String> getAllLanguages() {
    return languages.values.toList();
  }

  String getCurrencyInfo() {
    if (currencies.isNotEmpty) {
      final currency = currencies.entries.first;
      return '${currency.value.name} (${currency.value.symbol})';
    }
    return 'N/A';
  }

  String getMapUrl() {
    if (maps.isNotEmpty && maps.containsKey('googleMaps')) {
      return maps['googleMaps'] ?? '';
    } else if (maps.isNotEmpty && maps.containsKey('openStreetMaps')) {
      return maps['openStreetMaps'] ?? '';
    }
    return '';
  }
}

class Currency {
  final String name;
  final String symbol;

  Currency({
    required this.name,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'symbol': symbol,
    };
  }
} 