import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;

  const MyButton({
    super.key,
    required this.onTap
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration:
            BoxDecoration(
              color: const Color.fromARGB(255, 233, 221, 221),
              borderRadius: BorderRadius.circular(8),
              
        ),
        child: Center(
          child: Text(
            "Sign in",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )
          ),
        ),
      ),
    );
  }
}
