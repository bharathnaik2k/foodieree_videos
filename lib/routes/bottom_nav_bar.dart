import 'package:flutter/material.dart';
import 'package:foodieree/screens/home_page.dart';
import 'package:foodieree/screens/map_page.dart';
import 'package:foodieree/screens/nearby_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> screen = [
    HomeScreen(),
    NearbyScreen(),
    MapScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            
            icon: Icon(Icons.home),
            label: 'Home',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Nearby',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_rounded),
            label: 'Map View',
          ),
        ],
      ),
    );
  }
}
