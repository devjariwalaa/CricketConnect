import 'package:crickett_connect/pages/loginpage.dart';
import 'package:flutter/material.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const CricketConnect());
}

class CricketConnect extends StatelessWidget {
  const CricketConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CricketConnect',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 19, 19, 19),
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}