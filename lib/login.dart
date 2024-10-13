import 'dart:ui'; // Import for BackdropFilter
import 'package:cold_mail_ai/code_sign_up.dart';
import 'package:cold_mail_ai/forgot.dart';
import 'package:cold_mail_ai/square.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  bool isloading = false;

  signin() async {
    setState(() {
      isloading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Invalid credentail", e.code);
    } catch (e) {
      Get.snackbar("Error credentail", e.toString());
    }
    setState(() {
      isloading = false;
    });
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  google_sign_in() async {
    setState(() {
      isloading = true; // Start loading animation
    });
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Get.snackbar("Error signing in with Google", e.toString());
    } finally {
      setState(() {
        isloading = false; // Stop loading animation
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Blurred Glass Effect
          isloading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 10.0, sigmaY: 10.0), // Adjust blur amount
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.3), // Semi-transparent white
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(20),
                        width: 300, // Set width for the login form
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Login',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 42, 165, 155),
                                    fontFamily: "Poppins",
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: email,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: const TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.white),
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(117, 255, 255, 255),
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white), // White border
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white,
                                        width:
                                            2.0), // White border when focused
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                style: const TextStyle(
                                    fontFamily: "Poppins",
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: password,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.white),
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(123, 255, 255, 255),
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white), // White border
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white,
                                        width:
                                            2.0), // White border when focused
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                style: const TextStyle(
                                    fontFamily: "Poppins",
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                obscureText: true,
                              ),

                              const SizedBox(height: 20),
                              Container(
                                width: 400,
                                child: ElevatedButton(
                                  onPressed: (() => signin()),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(94, 0, 0, 0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40,
                                          vertical: 15), // Padding
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        // Button shape
                                      ),
                                      side: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 138, 138, 138))),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        'Or continue with',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 30),

                              // google + apple sign in buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // google button
                                  SquareTile(
                                    imagePath: 'assets/google.png',
                                    onTap: (() => google_sign_in()),
                                  ),

                                  const SizedBox(width: 20),

                                  // apple button
                                ],
                              ),

                              const SizedBox(height: 50),

                              // not a member? register now
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Not a member?',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontFamily: "Poppins"),
                                  ),
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CodeSignUp()),
                                      );
                                    },
                                    child: const Text(
                                      'Register now',
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color:
                                            Color.fromARGB(255, 42, 165, 155),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color:
                                            Color.fromARGB(255, 182, 181, 181),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Forgot()),
                                  );
                                },
                                child: const Text(
                                  'Forgot password ?',
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Color.fromARGB(255, 42, 165, 155),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
