// ignore_for_file: unused_import, prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:country_details/elements/custom_slider_navigation.dart';
import 'package:country_details/screens/country_details_screen.dart';
import 'package:http/http.dart' as http;

class CountryScreen extends StatefulWidget {
  final String name;

  const CountryScreen({super.key, required this.name});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  var data;

  Future<void> getCountry() async {
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist("API_Country");
    if (!isCacheExist) {
      final response =
          await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

      if (200 == response.statusCode) {
        APICacheDBModel cacheDBModel =
            APICacheDBModel(key: "API_Country", syncData: response.body);

        await APICacheManager().addCacheData(cacheDBModel);

        data = jsonDecode(response.body.toString());
      } else {}
    } else {
      var cacheData = await APICacheManager().getCacheData("API_Country");
      data = jsonDecode(cacheData.syncData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: backgroundImage(),
        child: Container(
          decoration: backgroundGrdient(context),
          child: FutureBuilder(
            future: getCountry(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if (widget.name ==
                        data[index]['continents'][0].toString()) {
                      return countryTile(context, index);
                    } else {
                      return Container();
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Padding countryTile(BuildContext context, int index) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 20, bottom: 5, left: 15.0, right: 15.0),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          CustomSliderNavigation(
            page: CountryDetailsScreen(
              name: data[index]['name']['common'].toString(),
              flag: data[index]['flags']['png'].toString(),
              index: data[index],
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).colorScheme.secondary,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: data[index]['flags']['png'].toString(),
                  height: 80,
                  width: 140,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 15),
              Flexible(
                child: Text(data[index]['name']['common'].toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration backgroundGrdient(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            Theme.of(context).primaryColorDark.withOpacity(0.8),
            Theme.of(context).primaryColorLight.withOpacity(0.9),
          ],
          stops: const [
            0.1,
            1.0
          ]),
    );
  }

  BoxDecoration backgroundImage() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/background.png"),
        fit: BoxFit.cover,
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        widget.name.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 25,
        ),
      ),
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
