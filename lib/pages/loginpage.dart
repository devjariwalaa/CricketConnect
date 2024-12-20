import 'package:crickett_connect/components/logo_widget.dart';
import 'package:crickett_connect/components/my_button.dart';
import 'package:crickett_connect/components/my_textfield.dart';
import 'package:crickett_connect/components/squaretile.dart';
import 'package:crickett_connect/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign the user in
  void signUserIn() async {
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
      // Attempt sign-in
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Close loading dialog if successful
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Close loading dialog first
      Navigator.pop(context);

      // Show appropriate error dialog
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

// Error dialogs
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Incorrect Email"),
          content: Text("No user found with that email."),
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Incorrect Password"),
          content: Text("The password entered is incorrect."),
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
              const SizedBox(height: 10),
              Text("Forgot Password?"),
              const SizedBox(height: 20),
              MyButton(
                onTap: signUserIn,
                text: "Sign In",
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
                        horizontal:
                            10.0), // Adds space between Divider and Text
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
              InkWell(
                onTap: () {
                  // Handle tap action here
                },
                splashColor: Colors.grey, // Color of the ripple effect
                highlightColor: Colors.grey[300], // Highlight color when tapped
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      onTap: () => AuthService().googleSignIn(),
                      imagePath: 'lib/images/google.png',
                    ),

                    const SizedBox(width: 25),

                    // apple button
                    SquareTile(
                      onTap: () {},
                      imagePath: 'lib/images/apple.png',
                    ),
                  ],
                ),
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
                 Material(
                  color: Colors.transparent, // Optional: Set the background color if you want it visible
                  child: InkWell(
                    onTap: widget.onTap, // Use this to trigger the tap action
                    splashColor: Colors.grey, // Color of the ripple effect
                    highlightColor: Colors.grey[300], // Highlight color when tapped
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // Add padding to your text if necessary
                      child: Text(
                        'Register now',
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
