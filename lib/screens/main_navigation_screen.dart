import 'package:flutter/material.dart';
import 'package:flutter_ui_fundamentals/screens/course_screen.dart';
import 'package:flutter_ui_fundamentals/screens/favorites_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    CourseScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Mendapatkan lebar layar untuk responsive layout
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        children: [
          // Tampilkan NavigationRail jika layar lebar (desktop/tablet)
          if (screenWidth >= 600)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.book_outlined),
                  selectedIcon: Icon(Icons.book),
                  label: Text('Kursus'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite_outline),
                  selectedIcon: Icon(Icons.favorite),
                  label: Text('Favorit'),
                ),
              ],
            ),
          if (screenWidth >= 600) const VerticalDivider(thickness: 1, width: 1),
          // Halaman Utama
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
      // Tampilkan BottomNavigationBar jika layar kecil (HP)
      bottomNavigationBar: screenWidth < 600
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.book_outlined),
                  activeIcon: Icon(Icons.book),
                  label: 'Kursus',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline),
                  activeIcon: Icon(Icons.favorite),
                  label: 'Favorit',
                ),
              ],
            )
          : null,
    );
  }
}