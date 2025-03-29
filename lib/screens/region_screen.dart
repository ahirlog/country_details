// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:country_details/elements/custom_slider_navigation.dart';
import 'package:country_details/screens/country_screen.dart';

var regionName = [
  "Africa",
  "Antarctica",
  "Asia",
  "Europe",
  "North America",
  "Oceania",
  "South America",
];

var regionImage = [
  "assets/africa.jpeg",
  "assets/antarctica.jpeg",
  "assets/asia.jpeg",
  "assets/europe.jpeg",
  "assets/north_america.jpeg",
  "assets/oceania.jpeg",
  "assets/south_america.jpeg",
];

class RegionScreen extends StatefulWidget {
  const RegionScreen({super.key});

  @override
  _RegionScreenState createState() => _RegionScreenState();
}

class _RegionScreenState extends State<RegionScreen> {
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: regionName.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 5, left: 20.0, right: 20.0),
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      CustomSliderNavigation(
                          page: CountryScreen(name: regionName[index])),
                    ),
                    child: regionTiles(context, index),
                  ),
                );
              },
            )),
      ),
    );
  }

  Container regionTiles(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).colorScheme.secondary,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(regionImage[index]),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
          const SizedBox(width: 15),
          Text(regionName[index],
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              )),
        ],
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
        "REGIONS",
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 25,
        ),
      ),
    );
  }
}
