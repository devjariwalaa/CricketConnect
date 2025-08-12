import 'package:flutter/material.dart';

class LiveScoresPage extends StatelessWidget {
  const LiveScoresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Scores'),
      ),
      body: Center(
        child: Text('Live scores will be displayed here'),
      ),
    );
  }
}