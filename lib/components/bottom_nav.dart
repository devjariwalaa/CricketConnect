import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// Make sure this import is correct.

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

 @override
Widget build(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width, // Full screen width
    color: const Color.fromARGB(255, 39, 39, 39), // Nav bar background
    padding: const EdgeInsets.only(bottom: 10.0), // Optional: for vertical space
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0), // Prevents edge cut-offs
      child: GNav(
        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
        backgroundColor: Colors.transparent,
        color: Colors.black,
        activeColor: const Color.fromARGB(255, 255, 255, 255),
        tabBackgroundColor:
            const Color.fromARGB(255, 253, 253, 253).withOpacity(0.2),
        gap: 8,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.score,
            text: 'Live Scores',
          ),
          GButton(
            icon: Icons.video_library,
            text: 'Video Hub',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
        ],
      ),
    ),
  );
}
}
