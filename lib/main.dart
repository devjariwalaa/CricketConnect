import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crickett_connect/pages/authpage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully.");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(const CricketConnect());
}

class CricketConnect extends StatelessWidget {
  const CricketConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CricketConnect',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 19, 19, 19),
      ),
      home: AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}