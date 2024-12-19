import 'package:flutter/material.dart';
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: Center(
        child: Icon(
          Icons.sports_cricket,
          size: 60,
          color: Colors.white,
        ),
      ),
    );
  }
}
