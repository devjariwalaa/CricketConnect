import 'package:crickett_connect/components/logo_widget.dart';
import 'package:crickett_connect/components/my_button.dart';
import 'package:crickett_connect/components/my_textfield.dart';
import 'package:crickett_connect/components/squaretile.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign the user in
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 126, 29, 29),
      body: Center(
        child: Column(
          children: [
            // logo
            const SizedBox(height: 125),
            LogoWidget(),
            const SizedBox(height: 35),
            // say login
            Center(
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 30, // Adjust this value to change the text size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 35),
            // user textfield (no padding)
            MyTextField(
              controller: usernameController,
              hintText: "Username",
              obscureText: false,
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 10),
            Text("Forgot Password?"),
            const SizedBox(height: 20),
            MyButton(
              onTap: signUserIn,
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    thickness: 5,
                    color: const Color.fromARGB(255, 93, 93, 93),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0), // Adds space between Divider and Text
                  child: Text("Continue with"),
                ),
                Expanded(
                  child: Divider(
                    thickness: 5,
                    color: const Color.fromARGB(255, 93, 93, 93),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // google button
                  SquareTile(imagePath: 'lib/images/google.png'),

                  SizedBox(width: 25),

                  // apple button
                  SquareTile(imagePath: 'lib/images/apple.png')
                ],
              ),
            const SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Register now',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}