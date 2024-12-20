import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.grey, // Color of the ripple effect
        highlightColor: Colors.grey[300], // Color when button is pressed
        borderRadius:
            BorderRadius.circular(8), // Rounded corners for the button
        child: Container(
          padding: EdgeInsets.all(25),
          margin: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 221, 221),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
              child: Text(text,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ))),
        ),
      ),
    );
  }
}
