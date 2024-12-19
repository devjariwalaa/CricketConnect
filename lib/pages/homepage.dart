import 'package:crickett_connect/components/bottom_nav.dart';
import 'package:crickett_connect/components/my_drawer.dart';
import 'package:crickett_connect/components/logo_widget.dart';
import 'package:flutter/material.dart';
import '../components/search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 126, 29, 29),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.settings,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNav(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(flex: 1), // Push content down
            Column(
              children: [
                // Title
                Text(
                  'CricketConnect',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                // Logo
                LogoWidget(),
              ],
            ),
            Spacer(flex: 1),
            // Search Bar
            AICustomSearchBar(),
            Spacer(flex: 3), // Adds space between search bar and attribution
            // Attribution Text
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
