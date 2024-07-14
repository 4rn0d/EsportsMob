import 'package:flutter/material.dart';
import 'package:vlr/app/rocket_league/following.dart';
import 'package:vlr/app/rocket_league/home.dart';
import 'package:vlr/app/rocket_league/region/regions.dart';
import 'package:vlr/app/rocket_league/news.dart';
import 'package:vlr/app/rocket_league/settings.dart';

class RocketLeague extends StatefulWidget {
  const RocketLeague({super.key});

  @override
  State<RocketLeague> createState() => _RocketLeagueState();
}

class _RocketLeagueState extends State<RocketLeague> {

  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const News(),
    const Regions(),
    const Following(),
    const Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index)
        {
          setState(() {
            _selectedIndex = index;
          });
        },
        indicatorColor: const Color(0xff2071c7),
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.article, color: Colors.white),
            icon: Icon(Icons.article_outlined),
            label: 'News',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.map, color: Colors.white),
            icon: Icon(Icons.map_outlined),
            label: 'Regions',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.star, color: Colors.white),
            icon: Icon(Icons.star_outline),
            label: 'Favorite',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings, color: Colors.white),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff2071c7),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
        title: const Text('Rocket League'),
      ),
      body: _screens[_selectedIndex]
    );
  }
}