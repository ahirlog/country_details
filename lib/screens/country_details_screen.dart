// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class CountryDetailsScreen extends StatefulWidget {
  final String name;
  final flag;
  final index;
  const CountryDetailsScreen({
    super.key,
    required this.name,
    required this.flag,
    this.index,
  });

  @override
  State<CountryDetailsScreen> createState() => _CountryDetailsScreenState();
}

class _CountryDetailsScreenState extends State<CountryDetailsScreen> {
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
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
            child: Container(
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Column(
                children: [
                  countryFlag(),
                  Divider(
                    height: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  countryDetails(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded countryDetails(BuildContext context) {
    return Expanded(
      flex: 3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.name,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 20,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                CustomRichText(
                  heading: 'Top Level Domain',
                  value: (widget.index['tld'][0] != null)
                      ? widget.index['tld'][0].toString()
                      : 'Not Available',
                ),
                SizedBox(height: 5),
                CustomRichText(
                  heading: 'Country Code',
                  value: (widget.index['idd']['root'] != null)
                      ? widget.index['idd']['root'].toString() +
                          widget.index['idd']['suffixes'][0].toString()
                      : 'Not Available',
                ),
                SizedBox(height: 5),
                CustomRichText(
                  heading: 'Capital',
                  value: (widget.index['capital'] != null)
                      ? widget.index['capital'][0].toString()
                      : 'Not Available',
                ),
                SizedBox(height: 5),
                CustomRichText(
                  heading: 'Currency',
                  value: (widget.index['currencies'] != null)
                      ? widget.index['currencies'].keys
                          .toString()
                          .replaceAll("(", "")
                          .replaceAll(")", "")
                      : 'Not Available',
                ),
                SizedBox(height: 5),
                
                CustomRichText(
                  heading: 'Dialing Code',
                  value: (widget.index['idd']['root'] != null)
                      ? widget.index['idd']['root'].toString() +
                          widget.index['idd']['suffixes'][0].toString()
                      : 'Not Available',
                ),
                SizedBox(height: 5),
                CustomRichText(
                  heading: 'Population',
                  value: (widget.index['population'] != null)
                      ? widget.index['population'].toString()
                      : 'Not Available',
                ),
                SizedBox(height: 5),
                CustomRichText(
                  heading: 'Demonym',
                  value: (widget.index['demonyms'] != null)
                      ? widget.index['demonyms']['eng']['m'].toString()
                      : 'Not Available',
                ),
                SizedBox(height: 5),
                CustomRichText(
                  heading: 'Region',
                  value: (widget.index['region'] != null)
                      ? widget.index['region'].toString()
                      : 'Not Available',
                ),
                SizedBox(height: 5),
                CustomRichText(
                  heading: 'Subregion',
                  value: (widget.index['subregion'] != null)
                      ? widget.index['subregion'].toString()
                      : 'Not Available',
                ),
                SizedBox(height: 5),
                CustomRichText(
                  heading: 'Language',
                  value: (widget.index['languages']['spa'] != null)
                      ? widget.index['languages']['spa'].toString()
                      : 'Not Available',
                ),
                SizedBox(height: 5),
                CustomRichText(
                  heading: 'Latitude & Longitude',
                  value: (widget.index['latlng'] != null)
                      ? widget.index['latlng'].toString()
                      : 'Not Available',
                ),
                SizedBox(height: 5),
                CustomRichText(
                  heading: 'Area',
                  value: (widget.index['area'] != null)
                      ? widget.index['area'].toString()
                      : 'Not Available',
                ),
                SizedBox(height: 5),
                CustomRichText(
                  heading: 'Population',
                  value: (widget.index['population'] != null)
                      ? widget.index['population'].toString()
                      : 'Not Available',
                ),
                SizedBox(height: 5),
                CustomRichText(
                  heading: 'Timezones',
                  value: (widget.index['timezones'] != null)
                      ? widget.index['timezones'][0].toString()
                      : 'Not Available',
                ),
                SizedBox(height: 5),
              ],
            )
          ],
        ),
      ),
    );
  }

  Expanded countryFlag() {
    return Expanded(
      flex: 1,
      child: Card(
        color: Colors.transparent,
        elevation: 10,
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: CachedNetworkImage(imageUrl: widget.flag)),
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

class CustomRichText extends StatelessWidget {
  final String heading;
  final String value;
  const CustomRichText({Key? key, required this.heading, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      children: [
        TextSpan(
            text: '$heading:  ',
            style: TextStyle(
                color: Theme.of(context).primaryColorLight, fontSize: 16)),
        TextSpan(
            text: value,
            style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold,
                fontSize: 16))
      ],
    ));
  }
}
