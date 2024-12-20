import 'package:crickett_connect/components/logo_widget.dart';
import 'package:crickett_connect/components/my_button.dart';
import 'package:crickett_connect/components/my_textfield.dart';
import 'package:crickett_connect/components/squaretile.dart';
import 'package:crickett_connect/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confpassController = TextEditingController();

  // sign the user up
  void signUserUp() async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from closing the dialog
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // Attempt sign-up
      if (passwordController.text == confpassController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        showErrorMessage("Passwords do not match");
      }

      // Close loading dialog if successful
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Close loading dialog first
      Navigator.pop(context);

      // Show appropriate error dialog
      if (e.code == 'email-already-in-use') {
        showErrorMessage("The email address is already in use by another account.");
      } else if (e.code == 'weak-password') {
        showErrorMessage("The password is too weak.");
      } else if (e.code == 'invalid-email') {
        showErrorMessage("The email address is not valid.");
      } else {
        showErrorMessage(e.message ?? "An unknown error occurred.");
      }
    }
  }

  // Show error message dialog
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 126, 29, 29),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // logo
              const SizedBox(height: 100),
              LogoWidget(),
              const SizedBox(height: 35),
              // say register
              Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 30, // Adjust this value to change the text size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              // user textfield (no padding)
              MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              // confirm password
              MyTextField(
                controller: confpassController,
                hintText: "Confirm Password",
                obscureText: true,
              ),
              const SizedBox(height: 10),
              
              const SizedBox(height: 20),
              MyButton(
                onTap: signUserUp,
                text: "Sign Up",
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0), // Adds space between Divider and Text
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
                children: [
                  // google button
                  SquareTile(
                    onTap: () => AuthService().googleSignIn(),
                    imagePath: 'lib/images/google.png'),

                  const SizedBox(width: 25),

                  // apple button
                  SquareTile(
                    onTap: () {},
                    imagePath: 'lib/images/apple.png'),
                ],
              ),
              const SizedBox(height: 45),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  Material(
                    color: Colors.transparent, // Optional: Set the background color if you want it visible
                    child: InkWell(
                      onTap: widget.onTap, // Use this to trigger the tap action
                      splashColor: Colors.grey, // Color of the ripple effect
                      highlightColor: Colors.grey[300], // Highlight color when tapped
                      child: Padding(
                        padding: const EdgeInsets.all(8.0), // Add padding to your text if necessary
                        child: Text(
                          'Login now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}